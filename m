Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F71409E14;
	Mon, 15 Jun 2026 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540804; cv=none; b=hS2O53kdGPY0W+1e2xwnmWLF9gE/NBIIctuKhh1U7Q0zx1PkhmCDAr+nqjbqcldOicjaRj0EhyX2juD1R64cFFNInB1nScu/gBhR8Yjd0NcZWX9tZMrjgKU8U0cev9njT8WEV4OLwXxgtZ7UmsYyRQXgiksT9T/R6YssF690XkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540804; c=relaxed/simple;
	bh=r0jeugGYwDbCkRzUZPQiz8N1uK0xqgeuWtEQnZmE5eU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ppNuUNrhm8CRAuNZ5K6WC9j3ALbm8fFshfVAgXDXgvasz8nvJPD991eDj0JM0wXVg0uNhA4s3MPTTQLGb1S0z/GOZIFr6qGOG0ppHrjP8HUw3eF9rsugXFk+Rp67/HGCduamnwMXQoWjE7tpwXuo24J6FWHc07zI1BlEWyIHGhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ap667TYD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ap667TYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3584E1F000E9;
	Mon, 15 Jun 2026 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540803;
	bh=3RDPe8QlQX3vqPNTwmYb6T6ji9UzSM8G/R2P7/Qsjog=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ap667TYDCOn1BGQ4YVIgnfzcTkV/81Z5PKY3aNATnu9ePc2htEFi7Lt2xKP7Yf1z5
	 hIxgBDteJBxBOUC17GTXzVnCNHrDa8FJLgSld9lOTT1FeguBGyVMktESnyc9mlmNG5
	 JR5TMgy8VPoHtGMgT4Khw2zMLbjHWQ7D+UKI8amr09933NWXS6W9zP4EFnnLKxCJ9x
	 bEZSzuUAbvb5h43zy/8U7a4518Z/zSw3HKVoNifMe9oz0br4NCtMgpmihJFEZvyPpA
	 Cv9MGwNzZj3+DwtGyFzbNiL/qFY3KRpBVIVRbeL/VPH2DIEYFNXZNegZ1dSi9ni/zi
	 doTzqGRuBGDPw==
Content-Type: multipart/mixed; boundary="===============2919116835290385840=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3d8e0694c62b87eec4aee4f35e6b91636b2c2f4c8bbc1790f612446d0d58a3e8@mail.kernel.org>
In-Reply-To: <5a2ca20101d9446d3a92815a8a3cc27b84db1754.1781535194.git.chenyy23@mails.tsinghua.edu.cn>
References: <5a2ca20101d9446d3a92815a8a3cc27b84db1754.1781535194.git.chenyy23@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: Add skb dynptr writer packet invalidation tests
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,bpf@vger.kernel.org
Cc: chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,john.fastabend@gmail.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 15 Jun 2026 16:26:42 +0000 (UTC)

--===============2919116835290385840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -1232,6 +1232,189 @@ int skb_invalid_data_slice4(struct __sk_buff *skb)
>  	return SK_PASS;
>  }
>
> +char dynptr_writer_data[8] = "test";
> +char dynptr_writer_dst[8];
> +
> +extern int bpf_dynptr_copy(struct bpf_dynptr *dst, __u64 dst_off,
> +			   struct bpf_dynptr *src, __u64 src_off,
> +			   __u64 size) __ksym __weak;
> +extern int bpf_dynptr_memset(struct bpf_dynptr *ptr, __u64 offset,
> +			     __u64 size, __u8 val) __ksym __weak;
> +extern int bpf_probe_read_kernel_dynptr(struct bpf_dynptr *dptr,
> +					__u64 off, __u64 size,
> +					const void *unsafe_ptr__ign) __ksym __weak;
> +
> +__noinline int global_dynptr_helper_write(struct bpf_dynptr *ptr)
> +{
> +	return bpf_dynptr_write(ptr, 0, dynptr_writer_data, 1, 0);
> +}
> +
> +__noinline int global_dynptr_helper_write_and_read(struct __sk_buff *skb,
> +						   struct bpf_dynptr *ptr)
> +{
> +	__u8 *data = (void *)(long)skb->data;
> +	__u8 *data_end = (void *)(long)skb->data_end;
> +
> +	if (data + 1 > data_end)
> +		return SK_DROP;
> +
> +	bpf_dynptr_write(ptr, 0, dynptr_writer_data, 1, 0);
> +
> +	/* this should fail */
> +	return *data;
> +}
> +
> +__noinline int global_dynptr_kfunc_memset(struct bpf_dynptr *ptr)
> +{
> +	return bpf_dynptr_memset(ptr, 0, 1, 0);
> +}
> +
> +__noinline int global_dynptr_kfunc_memset_and_read(struct __sk_buff *skb,
> +						   struct bpf_dynptr *ptr)
> +{
> +	__u8 *data = (void *)(long)skb->data;
> +	__u8 *data_end = (void *)(long)skb->data_end;
> +
> +	if (data + 1 > data_end)
> +		return SK_DROP;
> +
> +	bpf_dynptr_memset(ptr, 0, 1, 0);
> +
> +	/* this should fail */
> +	return *data;
> +}
> +
> +SEC("?tc")
> +__failure __msg("invalid mem access 'scalar'")
> +int skb_pkt_ptr_invalid_after_global_dynptr_write(struct __sk_buff *skb)
> +{
> +	__u8 *data = (void *)(long)skb->data;
> +	__u8 *data_end = (void *)(long)skb->data_end;
> +	struct bpf_dynptr ptr;
> +
> +	if (data + 1 > data_end)
> +		return SK_DROP;
> +
> +	bpf_dynptr_from_skb(skb, 0, &ptr);
> +	global_dynptr_helper_write(&ptr);
> +
> +	/* this should fail */
> +	return *data;
> +}
> +
> +SEC("?tc")
> +__failure __msg("invalid mem access 'scalar'")
> +int skb_pkt_ptr_invalid_inside_global_dynptr_write(struct __sk_buff *skb)
> +{
> +	struct bpf_dynptr ptr;
> +
> +	bpf_dynptr_from_skb(skb, 0, &ptr);
> +
> +	return global_dynptr_helper_write_and_read(skb, &ptr);
> +}
> +
> +SEC("?tc")
> +__failure __msg("invalid mem access 'scalar'")
> +int skb_pkt_ptr_invalid_after_dynptr_memset(struct __sk_buff *skb)
> +{
> +	__u8 *data = (void *)(long)skb->data;
> +	__u8 *data_end = (void *)(long)skb->data_end;
> +	struct bpf_dynptr ptr;
> +
> +	if (data + 1 > data_end)
> +		return SK_DROP;
> +
> +	bpf_dynptr_from_skb(skb, 0, &ptr);
> +	bpf_dynptr_memset(&ptr, 0, 1, 0);
> +
> +	/* this should fail */
> +	return *data;
> +}
> +
> +SEC("?tc")
> +__failure __msg("invalid mem access 'scalar'")
> +int skb_pkt_ptr_invalid_after_global_dynptr_memset(struct __sk_buff *skb)
> +{
> +	__u8 *data = (void *)(long)skb->data;
> +	__u8 *data_end = (void *)(long)skb->data_end;
> +	struct bpf_dynptr ptr;
> +
> +	if (data + 1 > data_end)
> +		return SK_DROP;
> +
> +	bpf_dynptr_from_skb(skb, 0, &ptr);
> +	global_dynptr_kfunc_memset(&ptr);
> +
> +	/* this should fail */
> +	return *data;
> +}
> +
> +SEC("?tc")
> +__failure __msg("invalid mem access 'scalar'")
> +int skb_pkt_ptr_invalid_inside_global_dynptr_memset(struct __sk_buff *skb)
> +{
> +	struct bpf_dynptr ptr;
> +
> +	bpf_dynptr_from_skb(skb, 0, &ptr);
> +
> +	return global_dynptr_kfunc_memset_and_read(skb, &ptr);
> +}
> +
> +SEC("?tc")
> +__failure __msg("invalid mem access 'scalar'")
> +int skb_pkt_ptr_invalid_after_dynptr_copy_dst(struct __sk_buff *skb)
> +{
> +	__u8 *data = (void *)(long)skb->data;
> +	__u8 *data_end = (void *)(long)skb->data_end;
> +	struct bpf_dynptr dst, src;
> +
> +	if (data + 1 > data_end)
> +		return SK_DROP;
> +
> +	bpf_dynptr_from_skb(skb, 0, &dst);
> +	bpf_dynptr_from_mem(dynptr_writer_data, sizeof(dynptr_writer_data), 0, &src);
> +	bpf_dynptr_copy(&dst, 0, &src, 0, 1);
> +
> +	/* this should fail */
> +	return *data;
> +}
> +
> +SEC("?tc")
> +__success
> +int skb_pkt_ptr_valid_after_dynptr_copy_src(struct __sk_buff *skb)
> +{
> +	__u8 *data = (void *)(long)skb->data;
> +	__u8 *data_end = (void *)(long)skb->data_end;
> +	struct bpf_dynptr dst, src;
> +
> +	if (data + 1 > data_end)
> +		return SK_DROP;
> +
> +	bpf_dynptr_from_skb(skb, 0, &src);
> +	bpf_dynptr_from_mem(dynptr_writer_dst, sizeof(dynptr_writer_dst), 0, &dst);
> +	bpf_dynptr_copy(&dst, 0, &src, 0, 1);
> +
> +	return *data;
> +}
> +
> +SEC("?tc")
> +__failure __msg("invalid mem access 'scalar'")
> +int skb_pkt_ptr_invalid_after_probe_read_kernel_dynptr(struct __sk_buff *skb)
> +{
> +	__u8 *data = (void *)(long)skb->data;
> +	__u8 *data_end = (void *)(long)skb->data_end;
> +	struct bpf_dynptr ptr;
> +
> +	if (data + 1 > data_end)
> +		return SK_DROP;
> +
> +	bpf_dynptr_from_skb(skb, 0, &ptr);
> +	bpf_probe_read_kernel_dynptr(&ptr, 0, 1, dynptr_writer_data);
> +
> +	/* this should fail */
> +	return *data;
> +}

This patch series was NACKed by Alexei Starovoitov in v3 with the comment
"nack. pw-bot: cr" (change requested). The companion verifier fix patch
(patch 1/2 in the series) was rejected, which blocks this selftest patch
from landing. A v4 was posted to address the helper-side bpf_dynptr_write()
case, but has not yet received maintainer feedback.

Are there plans to address the maintainer feedback and resubmit the series?

Reference: https://lore.kernel.org/bpf/DJ9QS5OUJTSG.1DSRYHG6GAG3H@gmail.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27557183694
--===============2919116835290385840==--
