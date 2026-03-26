Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EF833D6D7
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541889; cv=none; b=Xhgsrk4NsmlDnMGtY4y2XMQQdAQSzxLDF19zAmltJSDNe3DImpua5wqVh7sfi00umYGvy5z3lZauG8TeM5TtnsNruFRq16xlgRG9vXYcdCLYQm3HKXQfHheN1rh+f5GBMSbPdGC1qz3hodovz/Ehf3YEdH/nGIfrbss9Qw928s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541889; c=relaxed/simple;
	bh=y1W0XCRRQ1FEwE1PB7Pmw3tnekL4Jc3S5pd3DjdJUMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ls45eoIXQ9pC77lGQ2OWKtTu35v6PlVJ5Vb7XspRNHVZMBuwayBsO8Fnfa0dMMFquDUsdrDWnaMU4p0ncfPjH6aeTib5iCPLBHswPGm0wt009xPSRCGzhjkgOY6pHN+EsuWLmV7Ybmlf+dg+O4vvTGlOtVyb7Ku5JvXiJl9Gxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ66CdRM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ66CdRM"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b8e8e7432so990826f8f.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774541880; x=1775146680; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0HPEQe5uE5+LWDmN+mNHMpGeaBo/3oOFMPJz8iZpzkA=;
        b=TZ66CdRMiO/ZvJ2UpqC5etIvHOarut4m1w57oTeO7lJ8UGG4u4nICJKz8ccFI5lkIj
         ILINJzGpm7GhA8ecsM7XFzd+4IxE/LEtHyldzTpyHlM/ofL2K/GTtls4j3Nzivs/ZdI0
         3eXZeyw6DcBy6HgMlG5tPm/UfFt1D80DQNzmxleM1JtHQUp9sNJD2ZY+fmbXbBLV6r6x
         2doI1jVeJxCI9a+8VoZcuELDJinaTRnvIqhvXjSiuh/w8cDsumiikxSJb8XT+iyTnRMd
         tHxjg/pBJ30j9MjW1OsRFC6LI4CKmIR4Rv0DSbXYLeNxc1qPOXSvLnBaZnI3pqPeGgFm
         peXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774541880; x=1775146680;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0HPEQe5uE5+LWDmN+mNHMpGeaBo/3oOFMPJz8iZpzkA=;
        b=UslPgTUSPOdM8JHrF5Ly8KWxIOGbFHiwhTF5c226rAVdFf2eRbpyDf15Jt4N2v9+gb
         rzUVbYTHQ81sTklQAcihv5TKh3qxERv3xrlJ1tthdeZfXvnpETZKNyVu4TTUqgVcmxMq
         L86kosHUSGHU5Hy5KmXbyil5XS+pBKJEbq1T3nF/NjKa5iEq120RGkbKritS4cx6UHdl
         CgYP5O8dD5vsAieHEAtYsGU/94zfVaN0SMA/KyuJb+aZrtX8P43h+Q2/XTjQooL7KObO
         ZlndjVksXQqYY3FThrD2d7aT4nlnic8f0HvH065WcM5AWr/ImA6PXwd9IKv2tzvEEBnB
         t2kA==
X-Forwarded-Encrypted: i=1; AJvYcCU/5N034eUvtyVM/vzE+i7AKDy8N5aI7FBz5Q4kNxQS7ewp7yRhqtP6nptriu8F2S/Vm9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YywzUsnzmj4kT07vhJstBagcwOROQx7mPUUnwhvHjCcr2VQC05A
	o9ePX12EXbkFAFTfTkduZtdg6P0B1Zo4GEA4pHGx1nFRiJZsKRMRxV68
X-Gm-Gg: ATEYQzzZXoADJI2/Rh0gelQh3HbZs6V9TRnMbGcNEv6SGt5WMG/f/LZhENJfINRz3Pm
	4L2+tNiJ0Ak0oZ5VdTuc2U+7UP4sG/vRuUneeT5sMhzbTGPrlE4zvx+Tbsnb3sSoGxZlcFoudra
	k/pY0dvxjKkzHj8CK68cXQ9khhL1mkh6yRTQd2jbM77Mcm3NhCJg0NrK1hoY76NGyAKwqVU397U
	qESlgM64JB/lH5hk/1mhtsM0hGkN5uJREnAAfVz5RpC1DWk8lEQz6RgeVIiH+CulYm33ROQ8lgc
	KWiyhJTQlKnb1zRQN3DTramWl+eHzJmk03TZeVDEu8DY10EXB7Vm9F9S1GJh+pzETnvHLCEVsHs
	mcoUlIXQOKMmxyghKsdihjb3znFxXPn2J+uWXDbFWMv5S24DMFUuY7VTIvf7BjkgTSBqHHIw+RE
	0e+t/DuyF7dtF9g8QbTTlnnA64xaX/tMioPg==
X-Received: by 2002:a5d:5f82:0:b0:43b:921f:3b26 with SMTP id ffacd0b85a97d-43b921f3b75mr6802472f8f.50.1774541878539;
        Thu, 26 Mar 2026 09:17:58 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e5f0sm8752603f8f.4.2026.03.26.09.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:17:58 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, ameryhung@gmail.com,
 kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 1/3] selftests/bpf: Fix task_local_data data
 allocation size
In-Reply-To: <20260326052437.590158-2-ameryhung@gmail.com>
References: <20260326052437.590158-1-ameryhung@gmail.com>
 <20260326052437.590158-2-ameryhung@gmail.com>
Date: Thu, 26 Mar 2026 16:17:57 +0000
Message-ID: <87ikaiimyy.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amery Hung <ameryhung@gmail.com> writes:

> Currently, when allocating memory for data, size of tld_data_u->start
> is not taken into account. This may cause OOB access. Fixed it by adding
> the non-flexible array part of tld_datg_u.
>
> Besides, explicitly align tld_data_u->data to 8 bytes in case some
> fields are added before data in the future. It could break the
> assumption that every data field is 8 byte aligned and
> sizeof(tld_data_u) will no longer be equal to
> offsetof(struct tld_data_u, data), which we use interchangeably.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/task_local_data.h       | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> index 7819f318b2fb..a52d8b549425 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> @@ -90,7 +90,7 @@ typedef struct {
>  
>  struct tld_metadata {
>  	char name[TLD_NAME_LEN];
> -	_Atomic __u16 size;
> +	_Atomic __u16 size; /* size of tld_data_u->data */
>  };
>  
>  struct tld_meta_u {
> @@ -101,7 +101,7 @@ struct tld_meta_u {
>  
>  struct tld_data_u {
>  	__u64 start; /* offset of tld_data_u->data in a page */
> -	char data[];
> +	char data[] __attribute__((aligned(8)));
>  };
>  
>  struct tld_map_value {
> @@ -158,6 +158,7 @@ static int __tld_init_data_p(int map_fd)
>  	struct tld_data_u *data;
>  	void *data_alloc = NULL;
>  	int err, tid_fd = -1;
> +	size_t size;
>  
>  	tid_fd = syscall(SYS_pidfd_open, sys_gettid(), O_EXCL);
>  	if (tid_fd < 0) {
> @@ -173,9 +174,10 @@ static int __tld_init_data_p(int map_fd)
>  	 * tld_meta_p->size = TLD_DYN_DATA_SIZE +
>  	 *          total size of TLDs defined via TLD_DEFINE_KEY()
>  	 */
> -	data_alloc = (use_aligned_alloc || tld_meta_p->size * 2 >= TLD_PAGE_SIZE) ?
> -		aligned_alloc(TLD_PAGE_SIZE, tld_meta_p->size) :
> -		malloc(tld_meta_p->size * 2);
> +	size = tld_meta_p->size + sizeof(struct tld_data_u);
> +	data_alloc = (use_aligned_alloc || size * 2 >= TLD_PAGE_SIZE) ?
> +		aligned_alloc(TLD_PAGE_SIZE, size) :
> +		malloc(size * 2);
It looks like there is no point having Patch 1 separately, most of it is
overwritten in the Patch 2, I understand you want to have fix and
simplification separately, but is it really worth it for this selftest.
>  	if (!data_alloc) {
>  		err = -ENOMEM;
>  		goto out;
> -- 
> 2.52.0
