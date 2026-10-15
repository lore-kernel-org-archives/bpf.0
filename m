Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF75542ED0
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083697; cv=pass; b=FKoSGmQN4ulIsrBjmcYI5T+8yR8SnA3E+feBTqGgmaNRxNu8iKKlTKpRlrlQ48IG51xkW5nj3Uaosq5YmE85ywhKzOCfYBkLp2GhVaSKng3y++VINYOy+G3kWA4dH5hzMHlA7HVddM4B4SGlV7lSZo/ViI6Cyn0rMy5ElvMi1Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083697; c=relaxed/simple;
	bh=2mIQHt2w6JreUbD2TROanCdTO/tWRibiQj9E4ij67Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JykFKGlF5VLIj5zZ5glBfbxwSEphAARLObThooI+vYqeboGMI4LmlcVuVXvmDqMYVrEL1nB18EpV0YbDg/VWnkv+9l5ymM9LJEPeV67PKW4SnNMqx8dgFhjC7OI6Z6k/WCIiyDdqyFoDDYOQvKR9LBrL2QUKGghSwCvcRbJbYfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sXS219N/; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXS219N/"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4f512029e45so1068335b6e.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 10:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792083685; cv=none;
        d=google.com; s=arc-20260327;
        b=sHlP4lhHsmcOh99/WnfOv3VGCYbvFe6/CVFlszIqf9Y22v8y4QR60WRTOoxwrFBDWI
         YgCXj78FhFMdWjm0WM/fhsnGs9+OKU7RZ2UBashozpKq6m3FkNOqM8wiMBa9N8nVFcX9
         Gp9DA6jGb7oeg3f+Eze4MibeuZFcQPwyXO7D97vksCuB2FeaUrZe8ggyxfFRcb0cz9kh
         ieNvWq6dGMu+4fD9SY6N287EackrYTL+JEbBBRh5N7zqyqBoxFC3rDtlpgCgn2OUee9e
         8age7XkJd2rYt3hg3U/jQ+xeqtCRY52x5vnhUa/W1gkddr3X78+WRnqo7wChv01eequk
         Z0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sh6S4L6abExAyHv3Pko2Q7AmJzUE2jSd9Tm1J7A1aDQ=;
        fh=whPiEDDuChkg4N/RosfQJJ758g7dwE6KKHlHT7rq4Gs=;
        b=GoeIK51wRwXuICaqmrqsEj76klrb6aKmqnRN4iF0/6eFINoTVZsloIzH49DzqdEMRX
         V3YgLL4sXVnGS41b301DzqLT36l2OQtd50pN7ZCiJCnihibw2ohrIIZCxJyPBEAYX9TM
         VyvXGh7cx/ZUkCpeWIiiC8dHZ+lfNm9+gDS9cLEC2d8fV7jKrWpRSgsYywdcgYOI9svV
         OhMnQaeohAyCTnZFVkdkVcUF47UxrtamwIH7/WYsYEbCskmpObzfXsPSWFkF6311h2mP
         y0Sn/Mh9WNV6wqJ4NK9PBXrP2HXOXzAwYg7MXs0FCGm79iVwPj5Kztil22jhGXO2wp2h
         S0FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792083685; x=1792688485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sh6S4L6abExAyHv3Pko2Q7AmJzUE2jSd9Tm1J7A1aDQ=;
        b=sXS219N/BK3v7doRoTJuSwbMM3u+i7mG1OjRLuKIaIxEzfc7xP71hFvhP4Nh5PxNZX
         W3R0qTpBeM00jofQV+AH5Cq9abTr4WOgsaLeTyNRNvNPvhI+CAtDL+o+1iE3qxf5eMuj
         heMEF5BauCJE4VzsToIsOOVrPcB6VLRBRIRMHQxF9gCDl2qergXdIopUKOHr8JNp+4Bu
         /f/KYGtwqV1kcuudRPU2JDJRduhaCSQ8kjkbDrCRqvDH4Odnrpl2lcCnMRBeq7Gm484u
         h0ruf3uyp4CNnTn6hQsMJi0vd7TOkVaKGwJqVcIwOxHNhfzRUtDcl30Apu1PyX/X+bUw
         pz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083685; x=1792688485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sh6S4L6abExAyHv3Pko2Q7AmJzUE2jSd9Tm1J7A1aDQ=;
        b=F6LMCe5Jde3gQvjDv/B+yzutcKGEUTjA0JIK/mBvQk5Fn+/j8Pv0KJAwIlpVB9v77C
         P8RvrdZ0n4SW3h5pKl2SHJ3Wvtir6KocSAOzCU3DzyeBOVZI246TcopzHVjvN9253YjH
         U6livb06L1OJMeFsWU9Kb1T6HVWCa6BX7KkIpwPqYxc5bXk5to953e4H9MW55phEBpA/
         khz4c2y4HTUSLjTIL7+ChTjpVx4EaqLg0WNpzTw66yNZm+/gMHA2G2nhfaITO3kjl/7c
         0BqjdILkE3w7j3gQzpbQAu2RwzhtNTWFh+J3nLtnmksbYiC6IIsGvjec2yRjAE0GOJbo
         2AJA==
X-Forwarded-Encrypted: i=1; AKwUvBznS4sZNILN/ffpGpS6O3Ih5MDawx5Kx+dLpeCGeJqY1Tk8Zloy+bDRqn3hhktvM2dt0lo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3/8+nedeZ95q+BKBRruz8PQSq9BeWlKyUuWf4Racjyj104VT0
	R4aRUgQDsvwHVbAY/5ZcTg30u5OqQJLrJUqV0EdeRSTCVN3HlayNGsRogcLDMkmORyniJXvnGkv
	R9HfpUMQadwCOlDIy2rumFfuwivisEcU=
X-Gm-Gg: AYBFou3o3J56FV7AAIRlQ0TAsmxJhpbl0K2UsFKzbOR1DzpkCCqqICwra1Foyx5I9c3
	FoDkmLwsEXo5qpm0nSJo1rSW59vyju/sH5Uk4YIQFRAcfV2qnS7/01Hf1hoOCNAkcX39pSQTh11
	5boDS7/h7Bdix2CwcC5NLa5S0GE/QtRL/vZBFEslSbNMXq6K5jZwHvK+4PY+yn8VYwHv5L8879D
	JIcwad6xYpjTfwEFot8VkaXoFhVeRQ/uitRBDXmjcDb3w7V3tizmh87sZD3PiSVpMZIFiuAZR7g
	kMin1zPDozZq1Of+M27od8DbSQ2mTrUH80j5cXhEUF7k4moRqR4kZfneYPkP/N1XPw==
X-Received: by 2002:a05:6808:14c5:b0:4f1:9d5b:3113 with SMTP id
 5614622812f47-50c5bf0c17fmr17222792b6e.67.1792083685196; Thu, 15 Oct 2026
 10:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791980149.git.zhilinz@nebusec.ai> <1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai>
In-Reply-To: <1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 15 Oct 2026 10:01:13 -0700
X-Gm-Features: AclHuK8i-euzJcQWjKq28ighqiRw5kdDd1_oZsY_AjK3q4Q3MZriRllLYnxFA0A
Message-ID: <CAMB2axNZ=Js_-jGodWE22VoeVmR=9AL2V8jr_t9G38eAaMs_ZA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] bpf: reject raw iteration over managed sk_storage values
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	martin.lau@kernel.org, daniel@iogearbox.net, leon.hwang@linux.dev, 
	mattbobrowski@google.com, menglong8.dong@gmail.com, kees@kernel.org, 
	bestswngs@gmail.com, memxor@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 5:24=E2=80=AFAM Zhiling Zou <zhilinz@nebusec.ai> wr=
ote:
>
> The sk_storage iterator exposes values as raw PTR_TO_BUF memory. Attach
> validation checks only the maximum access against value_size, so BPF
> programs can read or overwrite BTF-managed fields such as __kptr without
> the verifier's ownership checks.
>
> Reject value accesses when the storage map has a BTF record containing
> managed fields. Iterators that do not access values, and maps without
> managed fields, retain their existing behavior.

AI is right. It also appears that iter/bpf_map_elem may expose special
fields as writable PTR_TO_BUF. Could you cover that path as well?

>
> Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
>  net/core/bpf_sk_storage.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 1d295a8769fa..b54fd90d4bde 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -863,6 +863,12 @@ static int bpf_iter_attach_map(struct bpf_prog *prog=
,
>         if (map->map_type !=3D BPF_MAP_TYPE_SK_STORAGE)
>                 goto put_map;
>
> +       /* The iterator exposes values as raw buffers, bypassing field ch=
ecks. */
> +       if (map->record && prog->aux->max_rdwr_access) {
> +               err =3D -EACCES;
> +               goto put_map;
> +       }
> +

Could we preserve access to non-special fields of the value? Since
max_rdwr_access is an exclusive upper bound and record->fields[] is
sorted by offset, attachment could be rejected only when:

prog->aux->max_rdwr_access > map->record->fields[0].offset

This remains conservative, while allowing users to place special
fields at the end of the value structure and iterate over the
preceding fields.

Please also add a selftest covering allowed non-special access,
rejected special-field access.

>         if (prog->aux->max_rdwr_access > map->value_size) {
>                 err =3D -EACCES;
>                 goto put_map;
> --
> 2.55.0
>
