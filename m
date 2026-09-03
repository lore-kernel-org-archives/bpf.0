Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A44B66D7
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446694; cv=none; b=l46sFouFVsjLI6FUotMVwU33hSqdW+4IPqJbVv/HJNnjf7H2bSEEoFAjHikPQRct84Od2jRPmB1wRAfywSdY2pzTS5ezKhUIH5YZsaSjf+X6rI3hB9geypjxcJUAKwXf6Ff0Q5/i6o+ZPHcQq/k14Ors/3s+4FNxGn6ifx9wRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446694; c=relaxed/simple;
	bh=wGZ7j1GsQxDq7SlMrCBwRSw7rOhHc5D/zanySNO76mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j683Rd9oBOE3spPe1RUJYe7zsJy7Le0NdgMSeezUZy5rc84kxxtJfyPhXxJp55JXDdnhurwsRmBABgVQ65ddEGd4gLPLixAX89YCVNc+46x7/y/kTv3CHmTlmpAm9CT7WeiFIGoUztaD4niSxwHuyFXvukoo06WIm7SAEvyZWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuvkfLI4; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuvkfLI4"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so4661775e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 07:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446691; x=1789051491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/GsHB+GAyFWAsQ4cGA6RNXMjmgvG2DlCXD9Wut3BYac=;
        b=BuvkfLI4NphW6Ln0CgmPzTmOEZjO9wNinkIaMPCPe1uwvgweJVGnoz2E/DsQ9k6l5/
         MWrXsAuEL8SVtsG0WaXcHBEPHQ456/pJ0rvQzz2c4/jGw3UznsDYwFfqBzztz/mjhBCD
         0pF8PBYiGpJnWw+fVOFrSUFkh/4lUKWpswV9KH29vkjL0++lL3+5lHMGMPk9qElKFGxu
         vC3BhwTAhEmc4Uzj1kqzj3aDAd9bPIPmFEkrp7Y0UVuesOTSDw9tH84lDUVBUBrqZlCu
         HE4MZOZ3Bk9plHab0rpHo6pkJPd6as6u3pnF9lhiT7JTleq+2GkvN3peelaP4ppM7JEu
         6HPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446691; x=1789051491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/GsHB+GAyFWAsQ4cGA6RNXMjmgvG2DlCXD9Wut3BYac=;
        b=Rkb0Y3ODE2xs/ATjaXZj5LJ8/YeWljJ03z+aCPTdfCSYdG3LF8HjpzlMuCgZ1Teezs
         Kj7Fb18/TYcSsX6EkZJZJLq98tX1KCOo9/PQiA4ieVZbPLRHcSQ1zf5eGZJKM11bzKpu
         U/4yNMIcHFoIwZ4QYoIrlJtWbGR4M3aRMmL3VpDEu7jjqfKf5lo2tTdFrrFCQ5NobVs3
         SXO9XzQWHCSaoYS6Cx/cmLoJN90uXS4LMBi+eCN6pX6XXV/oOolEfLnUqrLARRkEwbCJ
         JX4MOez1SwEEp+7adkD8++d+QeGRGJuRRjgiawrZQ0OssUehRMEBA+S2371wELBeqyke
         YBzg==
X-Gm-Message-State: AFuF++lXjCeXlr3xVot5gNXjWCBl2YG7gagxT9KDl6maBFh1DnW5qKRE
	tL5IhQK7BmjSvy+Mmb4Y9D7gfDFZBOT1Xmt4iUyt75pQFwrcPaTvCXdwrOCoBQJ8
X-Gm-Gg: AYBFou1v9wve7gTPa9z4fZcGfdZ+lwtETJAQts9fvks8CBOmgoudjc7qkJQwTpITTql
	/02KXsdJ7Hg7oLHm917orXrjXw7FHzOEdG/LIOrKOZTvDt/0FZ0vFgU6CcdaBSZEfZmd5zRIUPS
	1C5BSej1b9pg5/I1NcbfFeCr05sfm2pH9NM0JvKRi9xi64Q7bECjCDKUgwhBlvFrwoJMPlC+BYw
	NVBXxGhlMhfnkHd/cAvHEypFkjQNyFdDkmdgV3mpl+x8BkvUCUYJhG0fMT2MNjmiORLbWOJ/he3
	4hIRygZNQ9ede0WyInZ6F8A/hcmcvxWy7AqzuFpFcaJBwZpg+LL9bhHdf1pzd2QRa8T2ywdLJCT
	uLSSRZ3c89CtgimSh7g8BlfzeCWhYPSoFnNFx+f4CAGFIHUwiDoshX5D24PoMny/zYSkc6XqcsM
	DUZ7pZ0s0yd0EwqtD0G0f9ErkedDTGh5IznbaAe6l5QWLuO/Km+QzfRDmjIaO8qHxdZ/uhlpS0E
	kpCj1Gxlk7P4oyXXLVg9uCqIsbFAaQbj9zhcLl9bAzWppcKJlv0cbNLNC0diGOthrm971IeqsY8
	8lnRaq5iazdE2LmGDOeyNjl4w8A=
X-Received: by 2002:a05:600c:470d:b0:499:9240:9a1c with SMTP id 5b1f17b1804b1-49ce58363f8mr193850225e9.15.1788446690830;
        Thu, 03 Sep 2026 07:44:50 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d1fe2sm86259905e9.3.2026.09.03.07.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:44:50 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 09/10] bpf: Mark syscall helpers as sleepable
Date: Thu,  3 Sep 2026 16:44:27 +0200
Message-ID: <20260903144433.1716731-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144433.1716731-1-memxor@gmail.com>
References: <20260903144433.1716731-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2023; i=memxor@gmail.com; h=from:subject; bh=wGZ7j1GsQxDq7SlMrCBwRSw7rOhHc5D/zanySNO76mk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtm86S2SXs+iJjwdcwvf9pr9+iia3pBzPwZk8MjNB6ky VnpfnPuKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwETUJzP8Dzi4MG7CvcWsD7LF Nh9NPnGzk8XrfrXglLlCX275/z114wPDb5a1hf7Hw7UYP9pMP8xq88bZ1zY89Jj8I5W/xtaz28M eMQAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

bpf_sys_bpf() executes the bpf(2) syscall body, which can take mutexes,
allocate with GFP_KERNEL, and wait for an RCU grace period.
bpf_sys_close() reaches close_fd() and filp_close(), which can sleep as
well.

Both helpers are limited to BPF_PROG_TYPE_SYSCALL, whose main program is
sleepable. That does not make every callback sleepable: a syscall program
can register a bpf_timer callback, and the verifier checks that callback
in a non-sleepable context while retaining the syscall helper set.

Without .might_sleep on the prototypes, such a callback can invoke
bpf_sys_bpf() from hrtimer softirq context and trigger a
scheduling-while-atomic failure. bpf_sys_close() is exposed through the
same missing context check.

Set .might_sleep on both prototypes so the existing helper-context check
rejects them from timer callbacks and other atomic regions. Calls from the
sleepable main body remain valid.

Fixes: 79a7f8bdb159 ("bpf: Introduce bpf_sys_bpf() helper and program type.")
Fixes: 3abea089246f ("bpf: Add bpf_sys_close() helper.")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6874ba1424af..c7bc9ba9b331 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6568,6 +6568,7 @@ EXPORT_SYMBOL_NS(kern_sys_bpf, "BPF_INTERNAL");
 static const struct bpf_func_proto bpf_sys_bpf_proto = {
 	.func		= bpf_sys_bpf,
 	.gpl_only	= false,
+	.might_sleep	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
@@ -6593,6 +6594,7 @@ BPF_CALL_1(bpf_sys_close, u32, fd)
 static const struct bpf_func_proto bpf_sys_close_proto = {
 	.func		= bpf_sys_close,
 	.gpl_only	= false,
+	.might_sleep	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
 };
-- 
2.53.0

