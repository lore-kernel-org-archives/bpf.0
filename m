Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542270;
	b=n7NaJTVgYnrSQI50Yfpor+rWHR+3sCCZHg8E9sbwiecQdN4/CzCn8hey7Skum2agY1hH
	 uLFaQcohEfb7SW1UL/nJ03hWOlL8NIx6DT3rpWOhKD5HBdSNFiS9TCYYgdjE0A/MBgAGT
	 8ibeYmhzGs6GsQqdV356agO6aaO9fBHEORfbJYXDhb84M/0iy2He6U1gwcly/r4gwhg2S
	 UzxlfDxKCpvpBX42XouAvUo7HjREHGoeNjV4mCKRZfTL/dRQ26pxwfu6HXPDb18Yy3DVT
	 3AT52a3gyXbWPEZDeOmd9ySXHpA9tAk5j4EF9OvYNXuucs4fmXW3o2cMMNo2jZVQJJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542270;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JlSSBgyYMlvWibbVaGsXdZ3TGupumbOdQSDEDu1iKhE=;
	b=VrDNCVMZt6J8uUsVhO3Ig3FT94oZELox2lvogoh2+NDu/VEot9pmDFWuJkM2Eig3uLCo
	 J44dCAfTmNvJhrNSO2RpsmmylDe2VtGDIvOVtQ+fZ8W6Acc+NhUIP48vfZhG3Q9o+gXCM
	 1LJutijuq6eJ4mkGJapQuArpkLmGzRJGyPiIymoeleKSfsserh2gL+H6f5voBBzpjvbpb
	 Vdm2nDrwNgO1pRZ8Ri2xIk5ykOq7FG416wK2xPZxBH/MLJAUh2ZzTyc74v4nS8ZvIPS29
	 wo5lI4BgYm7BIxhDl45TtH7S6BwYT50+2XLjkx1A8aLfF0hqZ9NBc8EIonfLqoI///Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ktbGshCL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB166606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ktbGshCL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BAF1F000C6;
	Tue, 24 Nov 2026 17:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542270;
	bh=JlSSBgyYMlvWibbVaGsXdZ3TGupumbOdQSDEDu1iKhE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ktbGshCLq5JTxIL4wT8oTEkGiAZmyGvYCIZD4KgPUTQpM3bqMNE8ntImA9vYHevOy
	 jgzl0uIpQib54nhRaZmoqagk0R6p/o/+oxRdc4dgBnoNah/slXH7/DxjzvapxFMtoL
	 FlJy2BQ04WcT281a6TZA4fnZ3xZJ3y0m04IBjCfrh0SJOhGWBk0Q8sUDluEnkEd6k1
	 YDmcEE+eZnCOuVuDBPLzWjyMF0ZfiWsjlIxw2uWs8gXHh2YWkV6k7RqS3BE6aGeOfl
	 CjSwzeevaQ6Zk6SJM4b0Uq1IwKPfM/PX1aoGhQ6+7fSgHeFmegIvhq6sxJ20TeUFLq
	 D8tUoH9TXKBrw==
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH bpf-next v1 04/10] libbpf: Account for the overwrite
 position in ring__avail_data_size()
From: Tamir Duberstein <tamird@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
In-Reply-To: <853ef5deb34f53b2007ab47699c889b730d87805.1795467315.git.memxor@gmail.com>
References: <cover.1795467315.git.memxor@gmail.com>
 <853ef5deb34f53b2007ab47699c889b730d87805.1795467315.git.memxor@gmail.com>
Date: Tue, 24 Nov 2026 12:44:15 -0500
Message-Id: <179554225568.72201.8708250684463465883.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1820; i=tamird@kernel.org;
 h=from:subject:message-id; bh=wBlytEBlm4KIofdqDFdt+uTFEftbfsU31C0fa/gOTY4=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDNmsZz5X7EtWem9n8t+/X6NDbZW8x7v2kye1vm/RetTUu
 8Fv8ZSKjoksDGJcDJZiiiyJoof2pqfe3iOb+e44zBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjoGPMwMUpAFO9dxPDX/kJ4k9WF3+bvDI1SnKlYODv8IklO3S2dEg+WPCUozBH/QvDbzbbS0o
 P8ph+fX5jVa72ObnrA7upwz79FboB1zfb3LDdxQ4A
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

> In overwrite mode the kernel overwrites the oldest records when the ring
> buffer is full, and keeps the position of the oldest record that is still
> there in overwrite_pos. The records between consumer_pos and overwrite_pos
> are gone, but ring__avail_data_size() still counts them.
> 
> Read overwrite_pos, which is the third unsigned long in the producer page,
> and return min(producer_pos - consumer_pos, producer_pos - overwrite_pos),
> like ringbuf_avail_data_sz() does in the kernel.
> 
> A 32-bit libbpf can't tell whether the kernel is 64-bit, in which case
> overwrite_pos is at a different offset, so it keeps returning producer_pos -
> consumer_pos.

This is pretty unfortunate.

> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/lib/bpf/ringbuf.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 78fcb3df243f..271c6b9b130d 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -28,6 +28,7 @@ struct ring {
>  	void *data;
>  	unsigned long *consumer_pos;
>  	unsigned long *producer_pos;
> +	unsigned long *overwrite_pos;
>  	unsigned long mask;
>  	int map_fd;
>  	bool overwrite;
> @@ -150,6 +151,13 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>  	}
>  	r->producer_pos = tmp;
>  	r->data = tmp + rb->page_size;
> +	/*
> +	 * overwrite_pos comes after producer_pos and pending_pos. Its offset
> +	 * depends on the size of the kernel's unsigned long, which 32-bit libbpf
> +	 * can't know.
> +	 */

This is because 64-bit libbpf is running on a 64-bit kernel - took me a
few moments to grok. Is a less obtuse spelling of this comment possible?

-- 
Tamir Duberstein <tamird@kernel.org>
