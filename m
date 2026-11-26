Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795654601;
	b=lIvCNIUBCoc+XWm6ynV7hAx9A/nXvR0MAdb4Tqz33MkIu3yCALbhbtfaUQpviSXnFRFL
	 Vq2WoeoUfpukzc8cjEDPrNTo4EPA9cKZYb3YMM3M6gn3wxkOZHpsfJbBQ8Xo+9J/ajMKo
	 CAjg45vwdvYfAkZNd2Eo0fLp2Jacx/6PU+kA+I/L6JOIoGmY1hY6yszudNMNETt/i5iAT
	 jttpPHcKKTnAd6bemeF68mqDYwQm00q97RsRBn/ORKFT7hIPKIiEsGqVAJkdexR8UKjbO
	 CHkkBTIm8JUO0UgjNUoxOspGybBmNXruSckUoMrRzsBCdGhR+dqj6VxwbxHA23wnffQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pULute/cSpO9w1jNy6a0ZqiMnyFQ7hsVd+2WyE3hZho=;
	b=zqd63LV7CvDzx3B6Po9LlXwyY9ep6oj52zBVhOEdNSyUKuCiVwDytDVB4oJQK/vUFgyu
	 7C4+Xrs2WKnw5rZ757YcJmaYNGnSSyHqxPgWO8RQ+F/4ke8A2O+53Iydj/vOGyn2fEKlg
	 0vuU6HxQ9/z+RsdMmQG6d8jhrDmh6A45PwMUZs7IcgyBogko/rpQcEQDwvAzsBXD9EQyn
	 kmYZ0xg/M3E3yRIkqmTC8I3ZsPTNEzazFkIsvSJHLovDEqat3pazG5iePXa581kbzpYFF
	 abtBKO2O1tNPx9S/iZl2uoFOpvSKXIeutjbVru9Cug7s3gSjO3C4ReDKaUJUs+8I4Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LbZn5Fbq;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE84606A323
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 00:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADE84606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LbZn5Fbq
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b612fd74e1so2261831b3a.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795654600; x=1796259400; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pULute/cSpO9w1jNy6a0ZqiMnyFQ7hsVd+2WyE3hZho=;
        b=LbZn5Fbq8Z0TvRTn/LboeEFGCooC47p2zcM/lJQxjQ8jzwyNeO6K16SIUDaRvJF/BH
         X6Bq8Mh5/rs3Qr/PpaubW16pkBmzAbxGJhz0b+1CTNcZWJxW5YZ9yUrDhsJw61sv7CvN
         OP51LGKlr/5l2BBvOoe7Ca0Q+d8k/7YIw3f/DtWrDKCjXX9BqQTafouA261vnRLmslxq
         1Lz+qOaNdI/XXqMoZLUoLqdOh/QjvXuyKRFUD191SICcekSAjOuinoZSToNV3H8BJw9p
         Fl6C9uXFAc5jymqgJlQ8QdYjb3TDQTzuWnAsRqVcNZo+7Yi5L6UGvfaCr721n9MuhHXk
         WjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795654600; x=1796259400;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pULute/cSpO9w1jNy6a0ZqiMnyFQ7hsVd+2WyE3hZho=;
        b=CN4S5YZLkoLLLh87CCJZxyMpJf7qy8tIa0f1NNZXwSQMP3fGCKoPlpwb1cKmvxPmo1
         WQPcCsyZ5ogDuHpqVMLB4Cu5CHbfKGR11LVsZ5Vc4cPWF52deCF7kewlyvsFBfH2cQ+c
         BSns6IS0Q3JkGBsIqX8jM9ZXzVg6xMkXRSJL6P9/HXxGWIkkQjUOR/iyM2KU9oBzmKwG
         z+30vu9YXvZwFkXa0kxi2wBAsyLcbZqH/S395fh7C2qxQJ2dUvLAgSxNArSgdavE0WUD
         impQkp7MUC9CZ2u+Fs6Gg91iRaFaEhaxoAPzCVqdRQXDPe9DuBgaf0yi3an88ZXUNEvR
         gv0A==
X-Forwarded-Encrypted: i=1; AL+hErGDm6GPg3jhj6Eq1NqqnvW8fJPKDZqLmW6FF9XF89BJpvS+l0X6CyDB+F6eNq657KMPDBM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+52OYO1RgSow+LthFEnelXnoXPcg0gymSkthcP2hOEvr2v9fVe
	2pBrVhchYF1o12YjvedzZ9kAnPSgK2tPZruxwPQJoSp51h26USvppVDW
X-Gm-Gg: AZFdTZcnuDLw24C2X43zjgj+4UEm0rG65byqrqkvOvQsNVnhOg53Y2d0zbXnI6TK8Dx
	2zjF+6VBCAwU+RKrLFzHrqne/C8kL33ChZX3xrjOPukTLnjvmarhdBxcRqDPIwZRwgWl/xPpyPl
	0bNIyFdr6pBjxj4eHtuT0YoABs2sITXCGhSTMtQLkwxrTxaXwC+tXKrGAhERbVIoSxxJPfNcMze
	jdPE2dbPd8wa5l5GwR6T6Y1LSS9gTUVV/m9de3aMlhdzx+Qdb3pULGvCHDk2HwKS0/u0nkP97CY
	Nh+FgrkMnLyH82JM7xbOKJRxByro31wO/cjRpCQBTSA/1IbAoTxcN0A1/9Jb8cHa2euyFA4oODp
	sTU4m4qQi98TYCvgBiDCvlbjrru3oo1JaUqMS6h5zR2LqhUwkC7VBxM+BoKfJWTWb0c+fmt7WCg
	OWfkvsmDUqWz9moNnkdZHIwEuyqYS4fN2Xxha3ResZknx2w+ih7OPGat/S5uTS2igLv7iBZL4+L
	5Gy1p+Hsk3iDRx7KJLG5jCde/JMGlCX8v8aoJs73bSlHkzD5P3aKRQtEDuByAK7FJTkmlIJfuVx
	YGrzSK098m9OhR+Bo+gONMVec0dC265aZ3ST1UOK/RmbE1udyI7C2ReH0ipmtXGwYQxHvJCfYkS
	Sp119oyPP7ukE9HJqyOKk75El/u5UYb/U5A==
X-Received: by 2002:a05:6a20:7489:b0:3eb:7d71:2696 with SMTP id adf61e73a8af0-4014d25bb7cmr18191862637.40.1795654599866;
        Wed, 25 Nov 2026 16:56:39 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4c43bsm9623445b3a.26.2026.11.25.16.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 16:56:39 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 00:56:39 +0000
Message-Id: <DN4QFIRN445M.9M05B3SZ7T44@gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/5] resolve_btfids: Exclude a set of
 functions by name
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Jiri Olsa" <jolsa@kernel.org>, "Alan Maguire"
 <almagui@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 <bpf@vger.kernel.org>
In-Reply-To: <20261125212849.868523-4-a.s.protopopov@gmail.com>
References: <20261125212849.868523-1-a.s.protopopov@gmail.com> <20261125212849.868523-4-a.s.protopopov@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 01:28 PM Anton Protopopov <a.s.protopopov@gmail.com> wrote:
> +		"bpf_remove_dentry_xattr_locked",
> +		"bpf_set_dentry_xattr_locked",

The bug from the log of patch 2 stays one call below the helper.
bpf_unlocked_sk_getsockopt() has no tag now.
It passes optval, ARG_PTR_TO_UNINIT_MEM, to __bpf_getsockopt():

	if (err)
		optlen = 0;
	if (optlen < saved_optlen)
		memset(optval + optlen, 0, saved_optlen - optlen);
	return err;

__bpf_getsockopt() is in net/core/filter.c and takes no bpf type.
By the rules in fmodret.c it keeps the tag with -EINVAL.
After a skip the memset() doesn't run and the prog reads its stack.
__bpf_skb_load_bytes() has the same memset() in front of -EFAULT.

can we skip bpf_*() and __bpf_*() of vmlinux by prefix ?
Both *_locked names go away.
Modules stay as they are, bpf_testmod_retval_*() need their tags.
A few lines in fmodret.c on top of patch 5

diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
index 384efb5..18b3fbc 100644
--- a/tools/bpf/resolve_btfids/fmodret.c
+++ b/tools/bpf/resolve_btfids/fmodret.c
@@ -93,8 +93,6 @@ static bool excluded_by_name(const char *name)
 	static const char *const names[] = {
 		"copy_from_kernel_nofault",
 		"aarch64_insn_patch_text_nosync",
-		"bpf_remove_dentry_xattr_locked",
-		"bpf_set_dentry_xattr_locked",
 	};
 	unsigned int i;
 
@@ -166,7 +164,8 @@ static int read_bpf_code(char ***names, size_t *nr)
 
 static bool is_bpf_code(char **names, size_t nr, const char *name)
 {
-	return bsearch(&name, names, nr, sizeof(*names), cmp_name);
+	return !strncmp(name + strspn(name, "_"), "bpf_", 4) ||
+	       bsearch(&name, names, nr, sizeof(*names), cmp_name);
 }
 
 /* Find kfuncs and helpers */
@@ -380,8 +379,8 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
 			continue;
 		if (excluded_by_name(name))
 			continue;
-		/* Skip the code of kernel/bpf and of the JIT */
-		if (is_bpf_code(bpf_code, nr_bpf_code, name))
+		/* Skip bpf_*(), __bpf_*() and the code of kernel/bpf and of the JIT */
+		if (!base && is_bpf_code(bpf_code, nr_bpf_code, name))
 			continue;
 		nr_scanned++;
 		err = scan_func(scan, func, &values);

