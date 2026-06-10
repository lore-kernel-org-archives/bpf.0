Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114D1DB356
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102203; cv=none; b=D1l+pdZtXIGN4jHriaLVDOvoyMMshS8orFHIllL+jDPS1QPbUzxDwHY1U41RkRs887Xa2/bubpe6kmiK2H8fIIilmdrZpnwrW/5L024vdjYEEcKQMojxX/i6ooYhYC8eKpUSzbZjpqtU9VOTu0XRNwUfo/GKkSgH9vJH4GuVXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102203; c=relaxed/simple;
	bh=WLRpxp2SAdtxHDHMdyxhkBNxEh3bE/rKkEtFQMBL8lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbXd9zojbZflknWLuwUTV+1rSPNR1gjoKqM6s7qIGsVHY2KPlxIiE7WJz95ZpJCgms/LINX+Rrm/X2XqX6xog34pV9ueLM+Wa7boIoS+4hY31aqv7e+8k9A+WYREtZREmfqtf2BlVI4ishjF3T5HkDguJ8VUacSle6Td5c5wO8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ec5eoRfe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ec5eoRfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CADB1F00893;
	Wed, 10 Jun 2026 14:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781102201;
	bh=fAh3hdP1A8xrtxkFUZoS4arI2XruuHyXfb0IS5zX/Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ec5eoRfexWbZl5cKIq5sh8BF6laQ1vChnvREwMpMyBGONy6CApsT6MFPeYgZOz504
	 B+d2IHwZphVCL82WFPLjoPufNVF47mLn1T1RCpnHTnsstSIVDTOqoXSeecFuLQ9qy0
	 YYrR0wTjbHB/Imo2KKsL+DbuPnrhCTBPNqBkUVrrIEpbpiwwPfANkReyDW/MpfP8DW
	 UVDs9AlJoaw6HVbnOW/uGRBsfL9vUALFT8fHK745gBfej4tcDf8L3ozIPm2L+koKEl
	 33MIDLZHtmbHlNSEjcH7R/YxXbzIAIq8hFJLM+qBwLkl6QI1xcS94bEs/xk4VIInuj
	 bUaET8jAR1DQg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 1/6] bpf: Use user_path_at for path resolution in uprobe_multi
Date: Wed, 10 Jun 2026 16:36:22 +0200
Message-ID: <20260610143627.804790-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610143627.804790-1-jolsa@kernel.org>
References: <20260610143627.804790-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolve the uprobe_multi user path with user_path_at() instead of copying
the string with strndup_user() and passing it to kern_path(). This removes
the temporary allocation and keeps the lookup logic in one helper.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 90432f0fc2a8..970ce7bbf99e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3226,7 +3226,6 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	void __user *upath;
 	u32 flags, cnt, i;
 	struct path path;
-	char *name;
 	pid_t pid;
 	int err;
 
@@ -3261,14 +3260,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
 	ucookies = u64_to_user_ptr(attr->link_create.uprobe_multi.cookies);
 
-	name = strndup_user(upath, PATH_MAX);
-	if (IS_ERR(name)) {
-		err = PTR_ERR(name);
-		return err;
-	}
-
-	err = kern_path(name, LOOKUP_FOLLOW, &path);
-	kfree(name);
+	err = user_path_at(AT_FDCWD, upath, LOOKUP_FOLLOW, &path);
 	if (err)
 		return err;
 
-- 
2.54.0

