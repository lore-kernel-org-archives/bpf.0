Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757600;
	b=bdSvvVmiL9Zzdpi8mKfjOzUUMJxmFCK/97YX/xZZgEnGZ9mXeAY3KQztXZHemg0x81oH
	 Crcj3W59fPR+A7kTsiZMirLsqO8KXWjmdSwNfXwR1by1DjGen6DOY4KFq2kra/1eCHxeq
	 V3pWVt+sK+12AxHz93wNwDxDoCZPbS5bhT+0RTKuTXQKp7J+vrHQYNthwD+IoEAG5AbNf
	 RJ8BbLlavcqLuCtoAvBWptDDNf6yBM8jfNNLBm+D7AU9FvJ0DJsQX4zRl9gAjX/VlOOk7
	 ln+WrsCrmarT77sKs97QpXb8GCFGl5/1dF+c2GQ4BQgmfS3T2KPdoGblIGiHeb9Ibhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757600;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=wXdtNYBPn+jDYR4MOfuMgMnbFDoyElLrBSz7s5Yy4UQ=;
	b=qdTq/D+VA1EtC3VZSEZJTn6Onc3I8h9M962ymjVUBKtYYbbDIjEhHGeyVAOUKldiwSq8
	 CVLmN2CaFfGfZGZnB2DyX7/vJvpVFIX/VoFZxrTu0KhvhLz0lXmxGbBLDdNcIOPzb8ZH+
	 29NhKd9CuYLLu0ZKNCeYQV7vaI/DKHYzYdhzB8PyO5KUCsX2ay2k8B3PawCZPPxGuYN5s
	 KfetFxvMb7CtJ1zDzZ276+PNlcVzFb/aSodq238RwoZw2U00GSerW7RjE5V2oFjVcJh5P
	 9y1rs4qB7lHb63WJINF3KQO5RQJhOumDJiAlUsHLBWJaPB+QDxCN30nUcBpx9L8t/yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeiiz9SI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B6606A332
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeiiz9SI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0971F00A15;
	Wed,  4 Nov 2026 01:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793757599;
	bh=wXdtNYBPn+jDYR4MOfuMgMnbFDoyElLrBSz7s5Yy4UQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eeiiz9SIJyRbR7PwO0gi2M978j6Q3MyAxA7Fyio9b+eVS7iFdPfPELyqCI69nio+C
	 GOKUeU2QfNI/jXXQMRzmxvjrwERiyYOU6BaiGe+MvwpSC8xAd+WIQKmzHfgGXbp48i
	 y0hzJmkvGA6tXkY9Gzrj9cmx6xV2IsLvJ4XJHNNyFzLF9IRY3PPFS+GV/Tk2RyUW45
	 PM4EERYitHMwavaIFevD6L2oEIfut7f7prHJpbnJVE+eMrYR4py0YEAYmELn9+izYM
	 DcvvUs8AR/L81EdKTF3WeL9m5C0QN/qpNum7JMjvjs7O+AjPwp4d4oLMb4CZl6p5DS
	 khlZ9RQDxDQTQ==
Content-Type: multipart/mixed; boundary="===============7390498071728758101=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <6689350cf7ceb51493c6d21f6ad574bd7d26ce3a2b954820c075b2c2337dacec@mail.kernel.org>
In-Reply-To: <20261104012401.1354861-6-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 05/14] libbpf: Support .bss.addr_space.1 section
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  4 Nov 2026 01:59:59 +0000 (UTC)

--===============7390498071728758101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Support .bss.addr_space.1 section

TL;DR: In init_arena_map_data(), unvalidated ELF sh_addralign/sh_size in the
new .bss.addr_space.1 handling may wrap data_sz, so a malformed ELF could
cause a heap buffer overflow in memcpy.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -3095,13 +3106,20 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
>  	return 0;
>  }
>  
> -static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
> -			       void *data, size_t data_sz)
> +static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map)
>  {
> -	obj->arena_data = malloc(data_sz);
> +	Elf_Data *data = obj->efile.arena_data, *bss = obj->efile.arena_bss;
> +	size_t data_sz = data ? data->d_size : 0;
> +
> +	if (bss) {
> +		obj->arena_bss_off = roundup(data_sz, obj->efile.arena_bss_align);
> +		data_sz = obj->arena_bss_off + bss->d_size;
> +	}
> +	obj->arena_data = calloc(1, data_sz);
>  	if (!obj->arena_data)
>  		return -ENOMEM;
> -	memcpy(obj->arena_data, data, data_sz);
> +	if (data)
> +		memcpy(obj->arena_data, data->d_buf, data->d_size);
>  	obj->arena_data_sz = data_sz;

Can data_sz wrap here?  Both arena_bss_align (from sh_addralign) and
bss->d_size (sh_size of a SHT_NOBITS section) come straight from the ELF
section header and are not validated.

For example, with data->d_size = 4096 and sh_addralign = 0xffffffffffffffff,
roundup() computes (4096 + (__y - 1)) / __y * __y, which wraps to
arena_bss_off = 0.  With sh_size = 8, data_sz = 8.

Similarly, with a sane alignment (arena_bss_off = 4096) and
sh_size = 2^64 - 4096 + 8, data_sz also wraps to 8.

In both cases calloc(1, 8) succeeds and the following
memcpy(obj->arena_data, data->d_buf, data->d_size) copies 4096 bytes into an
8-byte buffer.  The path is:

bpf_object__open_mem()
  bpf_object_open()
    bpf_object__elf_collect()
    bpf_object__init_maps()
      bpf_object__init_user_btf_maps()
        init_arena_map_data()

The old code was malloc(d_size) followed by memcpy of d_size, so it could
not overflow.  libbpf has fixed other malformed-ELF arena crashes before,
for example 42be23e8f2dc ("libbpf: Verify that arena map exists when adding
arena relocations").

Should this reject a sh_addralign that is not a power of two, and fail when
arena_bss_off < data_sz or bss->d_size > SIZE_MAX - arena_bss_off?  Capping
the total at the 4 GB arena maximum would also work.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41755299448
--===============7390498071728758101==--
