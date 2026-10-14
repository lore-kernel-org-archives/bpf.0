Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF10E4457C6
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014313; cv=none; b=f7fDZgsN1XfwPBLqLyvKMxijzRLq4Az7bfK3JNFH9SkZwdjWvRXh+D1lnl1SpE6BEQ7cz9Dg7Td3ZaZVzXVPIJoOkag9wP5nfrkVTzI7QRSJ52BliQnLTT6TsikgHHrn2bEb5XitMIR31brJlmwdp8fpjTp6CTxrXkFaSoD+bDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014313; c=relaxed/simple;
	bh=0ZTSOvLPpcGRwqyN5BDZjWGpfTwuRbDfqUoQiVm6QnM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4pgMSlyHjpFAATNfpg6p/NitjljChhKP0JREs3o7XNv6TzwF82Cx9rhB275b/+HgpGPnQBA66lM3wfe3W0m2eZIfp6kstEAP0O8tvIlBrtbXoSlgezE2LZqoCswOzSTSqFNfjn0o30/DPGFbna5dXz07UT7Hp1ZEkxI7aAqOcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8e8L0hB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8e8L0hB"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48afe75f055so860319f8f.2
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 14:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792014310; x=1792619110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DYwmofQDCDn8korfzzaOGpjDzGREvYtvvSRPaGLYBs4=;
        b=m8e8L0hBlfEHnHvgXcPV1GkVMzjSyVPjEtxx6TFqKwbY5VDtgk8+iWpTVp4WxYKwaV
         vN46WE69yXf4FXxSyCU+KmpNms37zDVcHKJuNNVUpTfCHvvTunyg5w5iuOPMwLyY+0bo
         wVGwkjYNeAqt8eBGfwLliW5i2HEy91xXcB7HX+BjtWbYJ7aEt9UKm46is0HhCEu5LdMp
         MIGulu0aVMtLlkEI9pr/v/wlhBOAr+3XPejxKuXPLzVLlCv0Wl/WAt6Uh+pET9jH2LQ+
         PmymPGJop0y2VzOfWb0bkrSqXe9Gsu6M7Ro4JfzZZoIBANHz1KcLAXItQRXxgsK/8yio
         dsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792014310; x=1792619110;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DYwmofQDCDn8korfzzaOGpjDzGREvYtvvSRPaGLYBs4=;
        b=0s9kkNpCaWCmhl6vg5Kl6XUR2rV71pLa5yA5KKSciKPVVEE9cm4nEMtpGpssfqPccy
         50OUE2NpUtkt95OMacG/Riln823j51hx641BaypAtsiZlkOBdSlkmbMehiQpRi41Ukj/
         Nk505s+hjnnBKLOl/nnobHYbkp3/yNZTOrpsgBjFg5WruD0n0kd+J8+C2Kv/NuWeVp8i
         ljf5CTqg6i9+xQEc2Tg/CEH5y4xhp8U92gNwtC7jskInOKPXvv8X12DgCrUGnmwFyvGX
         /V5zFuH7rRVT/fFsOr6OMWxZSn97eFlLc7j4zfqJPSj3w8mc/mkmHMxoo0iX7+KLtT8p
         2zkg==
X-Gm-Message-State: AFq9FYJbfCdZFVclDICHXIFguXPqJMOaod2S3/d4483KopHiJ35GlIki
	sMlbcjdCqtIaU+OBSJ0Je5UY8BvaA7Bi3rmwmrGcC836KjBbv4gWztot
X-Gm-Gg: AYBFou38W1K317V7pUvskYXH5S5wvBOC4YxCbwWzL+Q3ZoCBHm60spY66UIfYoZkjRp
	KT9X1DQidoH7C4bgFjgefOOpHoswlQpS7x9Lx+10I/hRGPnK1v/3KOPBwJfoSLvsNCi9NBWTHQR
	PIhjXT2MR646msmSxXzhUnMqDuFe++TAg/b5GbZKd5g1F6dpYq2bIluvVDq+z1Igln8nHs0/n1U
	0vOUgPLbVBZaIsOKWU1EMTtG3Q9+ckXWXFkVSQ7p1ZvnHdHWRXp5iJRVJ+mOXnU+6LDFdh90X1U
	BT21KyS3PTU2cQCkNfLZUye7boT4lIxiX7iNAePghAZ6h0nJk2oeImVY+2UGCMYgW1t7NlW7feh
	iyAAN8wdneyzq+tdqdrkOyw2TgQriRr4ldT1jo7ZIvSM+G9Xjis/W/4nNcwVFbme3RPbexYvzDo
	FpdzxUUdEunA9RcGAOk6misOcla+oSZcK7QyaKBOf5nkPfp0fskmHVuCf8wQ==
X-Received: by 2002:adf:f549:0:b0:487:489:7af0 with SMTP id ffacd0b85a97d-48dbaadde34mr25680625f8f.17.1792014309866;
        Wed, 14 Oct 2026 14:45:09 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0514ab1sm18967193f8f.0.2026.10.14.14.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:45:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Oct 2026 23:45:07 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>, Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>, Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 11/21] bpf: Add tracing_multi link support
 for bpf progs
Message-ID: <as_349cckxgUQM2U@krava>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
 <20261012154024.29423-12-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012154024.29423-12-leon.hwang@linux.dev>

On Mon, Oct 12, 2026 at 11:40:13PM +0800, Leon Hwang wrote:

SNIP

> @@ -3787,64 +3796,129 @@ static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
>  #endif
>  };
>  
> -static int ids_cmp_r(const void *pa, const void *pb, const void *priv __maybe_unused)
> +struct tracing_multi_sort_data {
> +	u64 *keys;
> +	struct bpf_prog **progs;
> +	u32 *ids;
> +	u64 *cookies;
> +};
> +
> +static int keys_cmp_r(const void *pa, const void *pb, const void *priv __maybe_unused)
>  {
> -	u32 a = *(u32 *) pa;
> -	u32 b = *(u32 *) pb;

I think you could just s/32/64/ and keep the rest in here and have simpler diff

> +	const u64 *key_a = pa, *key_b = pb;
>  
> -	return (a > b) - (a < b);
> +	return (*key_a > *key_b) - (*key_a < *key_b);
>  }
>  
> -static void ids_swap_r(void *a, void *b, int size __maybe_unused,
> -		       const void *priv __maybe_unused)
> +static void keys_swap_r(void *a, void *b, int size __maybe_unused,
> +			const void *priv __maybe_unused)
>  {
> +	const struct tracing_multi_sort_data *data = priv;
> +	struct bpf_prog **prog_a, **prog_b;
>  	u64 *cookie_a, *cookie_b, *cookies;
> -	u32 *id_a = a, *id_b = b, *ids;
> -	void **data = (void **) priv;
> +	u64 *key_a = a, *key_b = b, *keys;
> +	u32 *id_a, *id_b, *ids;
> +
> +	keys    = data->keys;
> +	ids     = data->ids;
> +	cookies = data->cookies;
> +	id_a    = ids + (key_a - keys);
> +	id_b    = ids + (key_b - keys);
>  
> -	ids     = data[0];
> -	cookies = data[1];
> +	if (data->progs) {

nit, let's unify with the rest of the code and have progs variable for data->progs ?

SNIP

> -	err = check_dup_ids(ids, cookies, cnt);
> +	keys = kvmalloc_objs(*keys, cnt);
> +	if (!keys) {
> +		err = -ENOMEM;
> +		goto error;
> +	}
> +
> +	for (int i = 0; i < cnt; i++)
> +		keys[i] = bpf_trampoline_compute_key(progs ? progs[i] : NULL, btf, ids[i]);
> +
> +	err = check_dup_keys(keys, progs, ids, cookies, cnt);
>  	if (err)
>  		goto error;
>  
> @@ -3908,19 +4022,32 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
>  	link->nodes_cnt = cnt;
>  	link->cookies = cookies;
>  	link->fexits = fexits;
> +	link->tgt_progs = progs;
> +	link->pokes = pokes;
>  
> -	err = bpf_trampoline_multi_attach(prog, ids, link);
> +	if (progs)
> +		err = bpf_trampoline_multi_prog_attach(prog, ids, keys, link);

you need keys computed ahead for dups check, so let's the above
bpf_trampoline_compute_key calls be the single place we compute keys
and pass keys to bpf_trampoline_multi_attach below as well?

> +	else
> +		err = bpf_trampoline_multi_attach(prog, ids, link);

nit, let's add empty line in here?

>  	kvfree(ids);
> +	kvfree(keys);
> +	kvfree(fds);
>  	if (err) {
> +		bpf_put_progs(progs, cnt);
>  		bpf_link_cleanup(&link_primer);
>  		return err;
>  	}
>  	return bpf_link_settle(&link_primer);

thanks,
jirka
