Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F7F4C626
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883216; cv=none; b=A9/0g0g4kGqeRTWCuv3Uejawkr4R4TYibwNx2NaOIKW2s4T5k+ZdQXSbtJ7X1HTCO8M6nfzuxyyFrvSR0GUwrrAKmqK/ALnrWLm6BcSASPXsHUOmLoDPvx/qNlFpbag1afC455WDjkjZF7BYzSYxW52+14/0CBnhN5Fdvign0Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883216; c=relaxed/simple;
	bh=N5J+7UVxM8UbWKxRgq6r4vsJjSVk8Z3GvBBePvlv0XM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ncHVbn60u+EZ4ajNLEIt2w8QEp1k7y94la1CtnmXFZ3j19ze+RH1xM7jmxEjhvPhh4uw8lXTNXzHVnGTdl8EPnw9h14nXxY3imcHSIQ7WGuzqMzRY0kY6AgmKQizSA19vXMR/CNMYEKWJT4zauCY2ePsNig2e0QMoWytseLvpc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jacPFRsS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jacPFRsS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DD7C433F1;
	Tue, 19 Mar 2024 21:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710883216;
	bh=N5J+7UVxM8UbWKxRgq6r4vsJjSVk8Z3GvBBePvlv0XM=;
	h=From:To:Cc:Subject:Date:From;
	b=jacPFRsS5x4/dRVmUaFbS5iRpbQtk/TAqMDmUkfwmmtlaJGFWzFh5Hv1S4d61noIO
	 +10NT5oSiaOyPLV1EF77lcge3n1R0pctda+wmdRG02ZMUujc+NTFDDnFt077ioZLgV
	 z/9DOv0SfB5T+EItRJNvlM8HJO7OdIyQxuW+nHI5HTWhUkzWc35/+CcTebjFDLQ/UI
	 u1GMM93O8q6Doje0xmb0kTKsxnPHLi2NdhczZCWVXF0YDda0gyOH5XkQGGJPiXaoGb
	 2stipDvORGfDtkGtruUOfIuBz+TFKC8gwA1+5onKpWlCVzrzrX2PKRLAV/SsoJe2rC
	 XVhh49R9aG6uQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH bpf-next] bpf: avoid get_kernel_nofault() to fetch kprobe entry IP
Date: Tue, 19 Mar 2024 14:20:13 -0700
Message-ID: <20240319212013.1046779-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_kernel_nofault() (or, rather, underlying copy_from_kernel_nofault())
is not free and it does pop up in performance profiles when
kprobes are heavily utilized with CONFIG_X86_KERNEL_IBT=y config.

Let's avoid using it if we know that fentry_ip - 4 can't cross page
boundary. We do that by masking lowest 12 bits and checking if they are
>= 4, in which case we can do direct memory read.

Another benefit (and actually what caused a closer look at this part of
code) is that now LBR record is (typically) not wasted on
copy_from_kernel_nofault() call and code, which helps tools like
retsnoop that grab LBR records from inside BPF code in kretprobes.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/bpf_trace.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0a5c4efc73c3..f81adabda38c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1053,9 +1053,15 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
 {
 	u32 instr;
 
-	/* Being extra safe in here in case entry ip is on the page-edge. */
-	if (get_kernel_nofault(instr, (u32 *) fentry_ip - 1))
-		return fentry_ip;
+	/* We want to be extra safe in case entry ip is on the page edge,
+	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
+	 */
+	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
+		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
+			return fentry_ip;
+	} else {
+		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
+	}
 	if (is_endbr(instr))
 		fentry_ip -= ENDBR_INSN_SIZE;
 	return fentry_ip;
-- 
2.43.0

