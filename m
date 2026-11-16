Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842823;
	b=HoN4iccodJ7oVx/YKZsOeUhaoV6gT/bsX8gg8ed+HCiUtbp8wCA/tsfXXGeWuJPoMiMn
	 VXFpQECUWF0xnfsDWuqL4IjnwiotP7rK2/uRe0Fa9fXzCT75MUUvXi3TWeoFvtF2fpPfz
	 6AT9llqizytXWmzduoWZULQrRBbGX2WYR72rplpYt0Ew7KFr4SWEMCCb95TJgSOAaK25C
	 AIEwL8qpvSG3Chrytan51ul/omXGbrggqwvHVrV+qDKd2JSjmPD2tvgDzoIu1Pdkup3br
	 kNXFHqwbCpG6njcsW5CXmQCwa3bKxbqUaNkJUaT4CG/sX12OJVyrZztZWrkx/F878nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V94CgJ5UEt4SOHuuSRCVQBT/SR14wJz22vhJXv28cMg=;
	b=iy4JbEZCfayenC9ylb8ZLCVgRy9h0VrbPJ1YWqNoJJ8voUiI5FE8ruLjJBfM//AGlr9p
	 VKu9IE5wfB08WlKa428kUQEyGkAOCngPupHZavHhu8ne9AqRBmDDtg5ZUptf3JbYmiveC
	 ZR3O2c5n503LgvZecDzGksgvSO4z03Ce8oOlzGQK6/SW8voAQIucEDPNEibh07bpkiDzy
	 RiOSnA8ntokelWCOPfkJ7xIWvf2ng7/JIdQkO17mOnrzzjjm50D9nkaoxZcQqvayVpO5Y
	 6xQCJ5ff6ZGlUwaE1O87d2uvDuqqUOLaStW2+I2deACp2WyKlPoqPi1nKsXoJHopbeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YKSPAjLA;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57F606A329
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B57F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YKSPAjLA
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso1226485a12.2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842822; x=1795447622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V94CgJ5UEt4SOHuuSRCVQBT/SR14wJz22vhJXv28cMg=;
        b=YKSPAjLAf08mm0t9SnrCsqP605KAXjXEy42+ZiABpYxplx3HL8it1DznML8X3AfFj2
         Ec3tm4Y1ccfI3u00aISGQm12ePWTseWDCAt6ATWJX4DSsoIaFdMc8R/uSKoeQklWQChz
         RgMlDGhl7ba+cmxEoNHBbgLQQPjS0OV7UVF41MN41cMeJuk9cKBBs6qbb1vkexdqnW0h
         uJ114+bUpT7BHqaZJzTziqHkYyN3cehfJ6wISGFDuV0Z+CvWNNsW411GIuzyYwAdw1T9
         eZ0pb6CW5092KKFVLHyYL1O/j63EU+loU+SqPhSlkt6+ZdBG7hdUdcvSy+dKdF6MEglP
         /N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842822; x=1795447622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V94CgJ5UEt4SOHuuSRCVQBT/SR14wJz22vhJXv28cMg=;
        b=DAlobuwvN8kKuHTO6YloT0k3txY+8aCMDGZj8tXh65/35U5x3xmtEWlRabyk21T7JW
         FMPO2zCxaQ1SGlFAq4hIWfZgS27qzpioBiV3501AU+FWkSfNiHt3nYChqh7jZQPf4tc4
         o9wkJVrQZyZW0Xd5f+j/9t2w3CB/oe2sY769QKb1yAL9fJa4d1ktamCp420hNnSOh4TN
         Xmi19Xn7OWQCqcPDO8REgLiBLv0EU+VlMaOsH2TJUkm0McKOfeFITNO5vMF6Zjs/cZ5L
         6pYviobCqcMT59ikWvf+5m3Kvi2DscXr9H1URhtO6Kb57g8LDXlIKMkh93rUko9a3KMQ
         7/+Q==
X-Gm-Message-State: APuU4Z9gASAp73LfUhDuyYRCLMlMz/H5dI8lWizuAUU/MSF944eIQk4k
	a9t71cKygqTyVZBwpSQLyBUPDZuAcGLMFtiaQidVKE2tXEzb5omjtcYb4OhCHQ==
X-Gm-Gg: AZFdTZeqFuDKMmsjL0MDNtc1i4M70PDJKV1J30Nkxj0G8BHhDZob5by0FmMaKhCuwsE
	meqOd9I7tfrz4Yu3zrdN4NRR0jlews3Z9hjWx+J13zUdRvZ0MMfSlW3uZ9C9J6A8s3hoo3CQH27
	vl/uJqg0rPisGwE53mm2G7L4245uMxs/otFHUXk1aB83sC7ftVyrZnx4bRuyxzRyepyDo0CoVqZ
	cmx7XrdWgleTfizeQREu84gn0TG2pau7S7904ftihuZ4I19igDPMTMbKUsx8JjciVYtQE/tNaRE
	FfX4GSGBXpcG+8uudc1dzeze2zRw+dT+/fJuJrC1b9fPhKSM0vsbAm3STgGQCc4Rnwoxos5uiLX
	DA/bRQ9c37imnkOsk+xXLwNrYBkxt5lyHNqGDauUnZ7QpW7pV35aL/Dea4Oc/4bDZjOxs0nNLV2
	bzmfy0yUJNA1UNRsVOme+D72z6SPF08IsRDAi5dLb4dznqXteNnbmxDTVr8SlZS76Cio9TCrmop
	L90xWrvjKv7AhtjHnpfwB5eC3Y5N/F3T/pSvftzbe8Qxe3cOfiZU/E3VG9BmMXDYdq162c3vc0q
	ns9XKiorjnDR8xTC8qKd40xkY+vXhzl9XYmsjUYdz7wummC9NyYMkFbG7aXKKgPb0PbNU3RHAWa
	PjvB2GElylgYapJ9IvpuPFdlfYLpaTwRNjM/EMxmkmF7Qa/LYhPh/OtoBYvGik7xc4THCPCCojQ
	==
X-Received: by 2002:a17:90b:584b:b0:3a7:9e3d:b3 with SMTP id 98e67ed59e1d1-3b1b0ccefabmr10169651a91.66.1794842822277;
        Mon, 16 Nov 2026 07:27:02 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197b76ccesm22149102a91.0.2026.11.16.07.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:27:01 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 05/21] bpf: Dump programs that have more than 524288 insns
Date: Mon, 16 Nov 2026 15:26:10 +0000
Message-ID: <20261116152626.4032587-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

kmemdup() stops at 4 MB. A program that loads cannot be dumped.

Fixes: c04c0d2b968a ("bpf: increase complexity limit and maximum program size")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 844b2c2951c6..a1af95dd315b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5076,8 +5076,7 @@ static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
 	u8 code;
 	int i;
 
-	insns = kmemdup(prog->insnsi, bpf_prog_insn_size(prog),
-			GFP_USER);
+	insns = kvmemdup(prog->insnsi, bpf_prog_insn_size(prog), GFP_USER | __GFP_NOWARN);
 	if (!insns)
 		return insns;
 
@@ -5252,7 +5251,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 			uinsns = u64_to_user_ptr(info.xlated_prog_insns);
 			ulen = min_t(u32, info.xlated_prog_len, ulen);
 			fault = copy_to_user(uinsns, insns_sanitized, ulen);
-			kfree(insns_sanitized);
+			kvfree(insns_sanitized);
 			if (fault)
 				return -EFAULT;
 		} else {
-- 
2.55.0

