Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139EF308F23
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877311; cv=none; b=f6irDabWFenEr5LvGcu+AKQSzNBUU6O04NelOI78UDcTVHM/SVHsqGgAYY9HjUYHt8SjeLNXQtwLy1hZQGZPRh0AneKazo9B6YzPfD8uVJYmok6y+BgjoamdVvShUMsa4dYl0fseVmkbpZNVS2KuVoJeNIJ7RJdEJSJRzsxUyik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877311; c=relaxed/simple;
	bh=BMMqjb8y8tGxAQ2nHC3v/ZHVz6TbJa5TiPmEZ25STPA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3odGtVif8DF2CXCjnnLs3mp0CT3S8YuInSafVbwA3nm9d2djng5huphJpfqu9BvrjETMKS1G8hQlF+CJU90jEGXJYhM3t7lEqM9oYisucVRQcCNsSQDQQ4JEKAxB1fg7ZPxmX9GdhjEVa3MvUrHG8n+83q0FUUvRuyQoALSi/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZsfN++J; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZsfN++J"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-462ebd5d37dso2349697f8f.1
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781877302; x=1782482102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mk2ExJ8mssbYqK4VLi0gGHsKPwoFv9NrzRAVNwNuOfM=;
        b=RZsfN++JLua5RPFZntKJPNvuhLSM+KaikSrufM/OGNSEz56yCMEx3oxTFnWn0j/6cL
         ryRee0ff0TQ4HfIvir87fhGkFwM+hFlBWQnyxZKldCw3cu4qezQX2svebSuuNpmHH32S
         o5IjhwFU0xijWxL1qDkflXZqxr523eji/5cLnd8sAzi5JQHMmA8AxhWGLza+cxlYbh2c
         qoCJx9OD9grACBMnu9tK4YM3mpYfMdAauzhLdRPVD0YrUdMLUtb3fFeiqY5jTXcrKIbA
         IRrD76fmTBzSKy3EcaBFnsQ3k/F7tqp2D3l1lpz0gEsgrJKSO5bZYm/Z9S4uXIu4SIkV
         4jGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781877302; x=1782482102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk2ExJ8mssbYqK4VLi0gGHsKPwoFv9NrzRAVNwNuOfM=;
        b=XiX/LnpmnU+Fklbzq43IevKdh522NIQmlaM7i1pXhFsnbbhfIil0YfO44Nxwd0Pinb
         Xq2Y2LpY1VQLFZvxh48gfJNcY1XVd8xbY7kCxPiaKw4eVw/T9QpfDMNYEXddcsswi48x
         xa4wOC0gT/RU4w8AF7lPJz/vOgzWapTg/301UBomtOa0ayd0VVx7J6TDTvk50OavhKxW
         F1YaOLWa5L/n5WJfNSXIi8jny+YpvXGLsyK00ABqYHHp+5xtdesFsr2AnQPNZ+rZiT5u
         fd9Tf95ryRZaDl3pq85eYqVG2+qrIJqK2nEcvLctVtft52SvOzF/TqcQ8Flua0/CXNuK
         yU0A==
X-Forwarded-Encrypted: i=1; AFNElJ+Zja4V4CaRgXUK8UXF5wrcYiBFS/Vg09kQmoVSkirjjfso2Hk/wcDl+9d/apwymYS3HDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVMeR1RMXoGTiJWbgzNA5RrRsXRENumziHCwJZJ/eHbDD6+dvw
	G4u+s7b2kJFeu1CloIV9OJ4dWvpJnCtWCJhzWFZv211iJm9CZDOim+YK
X-Gm-Gg: AfdE7ckZ12/T0GtJpP2c3mnzZ7G4fIaqtJsGEEQUPSRhR8LhRkuXi+Rwoaq12racUGW
	ENDq8N2Lwod1BX1sO64WezGgAgdXH/H9qRianf/IX3k8orHsLt3IX6ThGplRLE7r6jDCxz1HZyl
	el4s5QEfLKqUlLxSlmqXTV0OUhWjlbvIA965eJfp9KPL9elHwWVmKF7KHYnnWkhtsN9PvUPppHO
	Xc5JnnbAhYgwps6LNdvKYSNCszUDa8Rn/kBtQZ4cGLmdvs8Wb4+XSFo/Fi7ozgwfoDvFlPFdIiU
	xX5THOUvmtWMmrO6NiXfUuNWNRmvKyC/STJv+sSDY07/eksRUhEWQ+0YKw/Z1ikYNflATjV0HNp
	VSXrwAIB+8oPfWOOdYF25vQqsQsdD6VpDX57LHdk8G9eqm6TtdAOYXOeToMK1ILlWVBdVwyUwLc
	pT
X-Received: by 2002:a05:6000:2382:b0:45e:f2e1:9a20 with SMTP id ffacd0b85a97d-46501d44e00mr7036218f8f.27.1781877301982;
        Fri, 19 Jun 2026 06:55:01 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46508a04c15sm8545498f8f.3.2026.06.19.06.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:55:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Jun 2026 15:54:59 +0200
To: Tamir Duberstein <tamird@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	David Vernet <void@manifault.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Andrew Werner <awerner32@gmail.com>,
	Zvi Effron <zeffron@riotgames.com>,
	Andrii Nakryiko <andriin@fb.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH bpf v2 2/8] libbpf: ringbuf: Prevent NULL callback crash
Message-ID: <ajVKM9tJskwg9OFa@krava>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
 <20260618-bpf-ringbuf-fixes-v2-2-33fde039ddf3@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-bpf-ringbuf-fixes-v2-2-33fde039ddf3@kernel.org>

On Thu, Jun 18, 2026 at 08:26:40PM -0400, Tamir Duberstein wrote:
> ring_buffer__new() and ring_buffer__add() allow a NULL sample
> callback. When callback-based consumption reaches such a ring, it calls
> through the NULL function pointer and crashes.
> 
> Check every ring before manager polling or consumption so a missing
> callback returns -EINVAL before the manager waits or consumes another
> ring. Check the selected ring before direct per-ring consumption. Perform
> both checks before honoring a zero record bound so invalid callback use
> always reports the error.
> 
> Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
>  tools/lib/bpf/libbpf.h                           | 11 ++-
>  tools/lib/bpf/ringbuf.c                          | 43 +++++++++--
>  tools/testing/selftests/bpf/prog_tests/ringbuf.c | 93 ++++++++++++++++++++++++
>  3 files changed, 136 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index bba4e8464396..9ba6b9ad3498 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1526,18 +1526,17 @@ LIBBPF_API int ring__map_fd(const struct ring *r);
>   *
>   * @param r A ringbuffer object.
>   * @return The number of records consumed (or INT_MAX, whichever is less), or
> - * a negative number if any of the callbacks return an error.
> + * a negative error code on failure.
>   */
>  LIBBPF_API int ring__consume(struct ring *r);
>  
>  /**
> - * @brief **ring__consume_n()** consumes up to a requested amount of items from
> - * a ringbuffer without event polling.
> + * @brief **ring__consume_n()** consumes up to a requested number of records
> + * from a ringbuffer without event polling.
>   *
>   * @param r A ringbuffer object.
> - * @param n Maximum amount of items to consume.
> - * @return The number of items consumed, or a negative number if any of the
> - * callbacks return an error.
> + * @param n Maximum number of records to consume.
> + * @return The number of records consumed, or a negative error code on failure.
>   */
>  LIBBPF_API int ring__consume_n(struct ring *r, size_t n);
>  
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index f2bb619d5a75..0dae4d95d309 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -231,6 +231,26 @@ static inline int roundup_len(__u32 len)
>  	return (len + 7) / 8 * 8;
>  }
>  
> +static int ringbuf_validate(const struct ring *r)
> +{
> +	if (unlikely(!r->sample_cb))
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static int ringbuf_validate_callbacks(const struct ring_buffer *rb)
> +{
> +	int i, err;
> +
> +	for (i = 0; i < rb->ring_cnt; i++) {
> +		err = ringbuf_validate(rb->rings[i]);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static int64_t ringbuf_process_ring(struct ring *r, size_t n)
>  {
>  	int *len_ptr, len, err;
> @@ -240,6 +260,9 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
>  	bool got_new_data;
>  	void *sample;
>  
> +	err = ringbuf_validate(r);
> +	if (err)
> +		return err;

as Emil noted in first version, this seems like overkill, could you
just check sample_cb != NULL before it's actualy called?

in [1] you mentioned you plan to add some feature that won't use sample_cb,
it'd be easier to review/suggest the solution with more details on that

jirka

[1] https://lore.kernel.org/bpf/e384ef2f478093a70af11980d2d1cdeb@kernel.org/
