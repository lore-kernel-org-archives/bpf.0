Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD21E51E0
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 02:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490948; cv=none; b=tIZfAgGCfOfljkmp9kWLGXl7FrN0BEvymaz0nU9OoL9X9EQIEQNg8nvNo5300zYWE9ZQN6/7sm4m+Ety+0vF4HMM8mqvsz2ViQ1tMXtv5voEpcBc4ZJomNSe9Dfr7LFOacHssL38ee0I6DSSL0KyGc+N4k0o8s/hqqq+ASB64kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490948; c=relaxed/simple;
	bh=8CtA1BAah7T7CAmtZQCzfJlkSKfvDWcJhiWhNoRCb6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKeJ/8Tvygf0XYKDPx1VE+f63fmhcVeN3bFjmjkjkIvFq08/josBGGEgvZm53tnAKwGB/oOwAzXaaMQdERjEVJpNJv7lpItxurCs3/sTZ0ELGb4KaCMsFzJJ1HLTqTtkmRAuLEzZf72FW0FkLI55ieR5cOvIj5TCVN6tyyTfwq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XZTCR6yo; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XZTCR6yo"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-41c420d1460so220897fac.3
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 19:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774490945; x=1775095745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/JLU1gejQqZao14J8ooTXxU2npvtEHMcTdwtYoGa0cQ=;
        b=XZTCR6yoF4SfzVzvKZi96HuQsADCXc86YUN/3/bW65y7VwizK4CAc1e9IvV7LMFZJv
         bUOUl+oJlhIf3qQ5iN212G/8ZUv0KvXgjODEFbk4NM887waOUO8XaAVwp/C5LRfyUJAA
         bHBHHsR6HinoAcaFI72tBtJ2r6YTTLNL+b0Q4g1ylvTgsxJdc2hODc5aVGlBDVvx5y/M
         HpdiY9FF3txnJnQU4ncpVldUnHQGQTCVD90TcXagDkknxlMo13PAva7fuTcK8b8hzVWm
         fUiuMyKAX8hmpNEbNN3I4YDAOnSEtEt80jnQ1Tl+ilsKKrJJPQkp52lIS013nuy4x8cc
         wLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774490945; x=1775095745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JLU1gejQqZao14J8ooTXxU2npvtEHMcTdwtYoGa0cQ=;
        b=Q/E4ZJc9LpYa+pjeDnsiqsQEdjcuEqDEEmCtCbT4/yBVHmIFNhH62kzaA6z5NIq6TL
         1LMocNuaAYvKmbggyFbYQa18LA5gJ/KTRM60m3Zl4hl05hLnNSrGCRwxweb0DwCnAmsD
         /ZD6DU7zCapDQ0jjnFmADZHvQSIPxPZDSWGBnPFpgyV91Qo2okKcNb/yS6wmoEIn7y2a
         KVQnmf6ql46etGawq/dyCf/g5HOSom/nvQchXASizQSpZgAXrnYbVqqgoOOVhsiMDhaT
         bA0as1+BWfdEbz11tbPxTrvK3HCQTqni3RrRGs7OWEsMnqrgk9sM7pAxKA0zS+S024gK
         xHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5JJrao5TKox2TOeVrBjVqC2BkbzEGVJzqQ0yF4qj7uYnZmsqCR3p4SXBa2V/fqdw4p/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUIE7tMnXNU4Y7ZSLqu70h7lk7xYteDcWbl5Vvec+EKpMaMOiz
	u/e8StGDUiXrAr8DLbSSadtvwpEiki7FJacYEc+VI5YYpXYu7XzsRFev76KGcATtUwxwQjM9Xqs
	twEKB9AM=
X-Gm-Gg: ATEYQzxfPBRq95iQ2QQcnsRG1bgIAV5+U9JuK7yaRjrTY5m1vfMZDunfYXsVFMRx/vE
	/eXVrEt+x0f9lyssKRP15jSzQobzzaRCn+9cxSQk1m822LESD/26ctgXSxjYCW2MyLf1VEE06kh
	h8KKc3+k1xRmYMED3pmMzOUq1vjTXWStgrNCAitjk1SNlNxsSQmjX7lZgkVOZYFVlRKbK9m9fx4
	oXyz0zmUGxvQby8dx+fA3q9Ena6Q4+y++NF9RoMKe6LD6EzeLWu6yziWwpg/VwF5+14nCA2OUvS
	+txvndN7QTopkpnJxO0R98EWqWBZzVo/OlxW6BGi2hdHQVXYGQ2pKkShAvUb+fqkzNBWDzb6aw5
	fp/r8CpqjI+pJc3TVBQoXFy9AQdnYicDzHfRYVaz3WxNqapzyfcdbVt9xlOD7AfW6yva75rtRGa
	YnUp5tAldbrIHaCgwnWEc9zz0Dz2/OltFDctbM6f68U2D+f0/oWjIKoWa2ORR2dVt4+jXO0mwrM
	/WgY6XWSKBwnz0mc2zK
X-Received: by 2002:a05:6870:a797:b0:40e:dcc9:c3a0 with SMTP id 586e51a60fabf-41ca6df1502mr3200041fac.17.1774490945480;
        Wed, 25 Mar 2026 19:09:05 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41cc7b3e55fsm1192963fac.14.2026.03.25.19.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 19:09:04 -0700 (PDT)
Message-ID: <b7216cd5-68f4-4ab5-b1c8-b1c71f38fc00@kernel.dk>
Date: Wed, 25 Mar 2026 20:09:03 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 05/12] io_uring: bpf: extend io_uring with bpf
 struct_ops
To: Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 Akilesh Kailash <akailash@google.com>, bpf@vger.kernel.org,
 Xiao Ni <xni@redhat.com>, Alexei Starovoitov <ast@kernel.org>
References: <20260324163753.1900977-1-ming.lei@redhat.com>
 <20260324163753.1900977-6-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260324163753.1900977-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 10:37 AM, Ming Lei wrote:
>  int io_uring_bpf_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  {
> +	struct uring_bpf_data *data = io_kiocb_to_cmd(req, struct uring_bpf_data);
> +	u32 opf = READ_ONCE(sqe->bpf_op_flags);
> +	unsigned char bpf_op = uring_bpf_get_op(opf);
> +	const struct uring_bpf_ops *ops;
> +
> +	if (unlikely(!(req->ctx->flags & IORING_SETUP_BPF_EXT)))
> +		goto fail;
> +
> +	if (bpf_op >= IO_RING_MAX_BPF_OPS)
> +		return -EINVAL;
> +
> +	ops = req->ctx->bpf_ext_ops[bpf_op].ops;
> +	data->opf = opf;
> +	data->ops = ops;
> +	if (ops && ops->prep_fn)
> +		return ops->prep_fn(data, sqe);
> +fail:
>  	return -EOPNOTSUPP;
>  }

Any early exit should ensure 'data' is sane, so that the cleanup doesn't
potentially touch uninitialized crap. This is something that has bit us
in the past. Not an issue for this patch that adds the code, but it will
be once the next patch is applied. Better to clear ->opf/ops here
upfront, so that we never leave this function without 'data' being fully
initialized.

-- 
Jens Axboe
