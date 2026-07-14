Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47836654F;
	Tue, 14 Jul 2026 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025613; cv=none; b=UFPra3Xgvd0YgL7uB+AjdWbLjR0FFamN+fesXH7XgulT5Bob8meArhV6Po7Bzl7wjgjCd7cIWZVHuackR0aiFSqY78i5t6nm2BR0CK54djJiF6aSUXpGJHKhx/TNvbux0rQVSLRSJl4xZ1drKVXguiewugSITdArNo1i9Lk9kFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025613; c=relaxed/simple;
	bh=c3vHekJDMrR9Avo+zc9/bWp8qelU6ljnUyk0cvw3fE8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=s6SKZyVokOibttYb3TOLWCs1TRetg0PavDuG1l7ZGGCqgOrpm/Q3e8TxTQ0X4MHnBRwLHe0GEa6Y9DA7sDjd3G7FW2Kx4sgubmY9TXYl3U/nsqZ8PH7008HsXb0alZdTu6F4z0igLVSH/Y/t2NhkkgI5TzAxQTr4MBo6JOxAE1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntTccBni; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntTccBni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A071F000E9;
	Tue, 14 Jul 2026 10:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784025611;
	bh=8myD+Y/KItLAzAG69GGfXEpLUYey1Tsv8sEPDDuGMLQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ntTccBni0tvf4gFs9NmSYwb01e0SnobCKJHeNclSorPIRtNvBTDLIEvjsGQun1BcF
	 H+jxBusR8HmZp3OxFviHqYfoffcLolSZOPsyQeOOTH8Z8XdGhjVwwVEOgKpIOr0mX4
	 KGy7sfk9Btw7kNyA4uaByC15Z4UTwM/FqUq3ZqDTW08vBgxbbxjDIRCrFMk4q5y+Ja
	 Ar4N6B996i2qlvGuNm1vLYe13Y8ubQ2UxvIxdS+01KqUAiaDPW2iEAcDtoRPjvEVIT
	 g+71DHpZEKM60lgPTebb+y+DMEff2Am406EVcvOWD0wrfRYxe9Sx2uvftK8Cwyv0o5
	 yclCu3U3uYrAQ==
Content-Type: multipart/mixed; boundary="===============7413882349097625299=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cad393253d7633ca397ec2a235596e2b45a52b595945253fc0451ce0446840ad@mail.kernel.org>
In-Reply-To: <tencent_59689407B1C3204B08362BEEF244A5FE5505@qq.com>
References: <tencent_59689407B1C3204B08362BEEF244A5FE5505@qq.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
From: bot+bpf-ci@kernel.org
To: rtoax@foxmail.com,andrii@kernel.org,vmalik@redhat.com,ast@kernel.org
Cc: rongtao@cestc.cn,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,ishiyama@hpc.is.uec.ac.jp,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 14 Jul 2026 10:40:11 +0000 (UTC)

--===============7413882349097625299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c18f1e16edee4..e99b643136822 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4195,6 +4195,95 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign,
> +static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
> +{
> +	int dlen, slen, space, copied;

[ ... ]

> +	for (copied = 0; copied < space - 1 && copied < sz; copied++) {
> +		__get_kernel_nofault(&cs, src, char, err_out);
> +		if (cs == '\0')
> +			break;
> +
> +		__put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);
> +
> +		src++;
> +	}
> +	cs = '\0';
> +	__put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);
> +
> +	__get_kernel_nofault(&cs, src, char, err_out);
> +	if (cs != '\0' && sz > copied)
> +		return -E2BIG;
> +
> +	return copied;

Here __bpf_strncat() returns copied, which counts only the bytes
appended from src.  It does not include dlen, the pre-existing length of
dst.

> +err_out:
> +	return -EFAULT;
> +}
> +
> +/**
> + * bpf_strcat - Append non-null bytes from a source string, and null-terminate
> + *              the result
> + * @dst__ign: Destination string.
> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
> + * @src__ign: Source string.
> + *
> + * Return:
> + * * >=0      - Length of the concatenated string.

The kernel-doc for both bpf_strcat() and bpf_strncat() describes the
success return as ">=0 - Length of the concatenated string."

Since __bpf_strncat() returns copied rather than dlen + copied, does the
returned value actually describe the number of bytes appended rather than
the length of the resulting string?

Should either the return be dlen + copied, or the documentation say
"number of bytes appended"?

> + */
> +__bpf_kfunc int bpf_strcat(char *dst__ign, u32 dst__sz, const char *src__ign)
> +{
> +	return __bpf_strncat(dst__ign, dst__sz, src__ign, XATTR_SIZE_MAX);
> +}
> +
> +/**
> + * bpf_strncat - Append non-null bytes from a source string, and null-terminate
> + *               the result
> + * @dst__ign: Destination string.
> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
> + * @src__ign: Source string.
> + * @len: the maximum number of characters to concatenate
> + *
> + * Return:
> + * * >=0      - Length of the concatenated string.

The same "Length of the concatenated string" wording applies here.

> + */
> +__bpf_kfunc int bpf_strncat(char *dst__ign, u32 dst__sz, const char *src__ign,
> +			    u32 len)
> +{
> +	return __bpf_strncat(dst__ign, dst__sz, src__ign, len);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29323723211
--===============7413882349097625299==--
