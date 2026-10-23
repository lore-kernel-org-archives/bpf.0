Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770543;
	b=tuA4Rm4ynT4Z4uy1kesYwfjvQvGAefN7KOUtv3W0XprhrkmsAfPI49gNzf+KGZRR1baY
	 GC9rNE56rbsuEAbfYfO33fEkktxiS3i+EpqqIYIJjlSeBlniVOMqx5zudT5hSOP55AEAV
	 KGmbiXiaqhia4Nw+LiTaQI+dFSy3XDTabKHCzYBdet0p2jZJpZ4l9H2qI18azmA0jVRpK
	 xMp/ysGwLKffjHp70xF8QQ/FLpL2mMI3G7WZmxm2zdMHW4ZGUYjYSlzYrJ/JCrGKwVCIa
	 CjFSFvSSU02RAb1r48bPnRzMK0g+OM2A6npJlB1m1EOlIIPCAXRBj3fBZCgW5y8iKFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770543;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=60Xs15W9jQQ2oWcJEMPCLV3YnsgNH1/hIQ/HS3LOjiI=;
	b=FrrTjs9pV2+aQbAtvDiN12OtyDdHdNGhB8Nf1AAo9xlSGaxJ2/49wna81tOP3cUJY+l2
	 u5lZTtg+MtHKIgegGVqMfh+9khxziOuH2Fm4btnaLtFIQMSgKDujhHaELuCEZq39EvFjH
	 +40HcJnZv/IuakZ+GjFRWxN5+I79NTWkqgPl4rjrogXfzkpyhb2b8Imc270n+DLzCSHEb
	 GTPLCSG17L8yIsHgpu/PU6chOnvv8q5Kl7jZW8Z7CZdl5gsLAjsDnBpnkaM9uXoXQoa2G
	 +mPPB49AXk+qyslGjQORTGzIHr+MfXJF5K6M0XBb1WTD64k3mwoku0AjgXJ+7K+JDhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XGD6UvWX;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53D4606A336
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 15:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A53D4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XGD6UvWX
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a070781f63so501583b3a.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792770542; x=1793375342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=60Xs15W9jQQ2oWcJEMPCLV3YnsgNH1/hIQ/HS3LOjiI=;
        b=XGD6UvWXxifq9S1XOEE05GyMGXg4B3IUDQzD7to/TAOkeLd4rCov112YIO2g9IHwaY
         9Ppbqaa3EDp0qaDBTjWj0qDxFK//F3JPLHhCqNCvguu8rDs1PZd0zHB8vzenMBwaDoW/
         X3jaVLUB7R6JK9l++9xRNnvjI+T9yn1QyYBD1K4pJRgfUMfBNmmtm4OnqRrYTr+Pwzhg
         Wrk9g4gymtEF5SQMBbQP8pa2KkCw/oExRPtb0lfaa6G3EW9Md/5JMR5FtM4RmHzFR8jL
         HJr7VIIKlb+E/h3qjD1YKqkjyXmzZ3pPf111/3DhzTSc61SGNLqC41n8Uxq4W0LIWd4w
         34dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792770542; x=1793375342;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=60Xs15W9jQQ2oWcJEMPCLV3YnsgNH1/hIQ/HS3LOjiI=;
        b=DGy+zdHkey6SfAbsX3KHQR/bYGXc+HBLKyjqnVRUEiXd0JhCZRftp6zKmziRD1RQNd
         Ch+NIMo9+od0KXN22mvBTlYxizp/YoicnZS/jcZf9+w1qpQJ5dqwJRpmIWAb/iQgX76A
         w0f6eTM+2PiS9fgiHdIkaBlnROuBXoy0cFVnlrsCFChnyppVST/YemYb8AeMW8tWaVrh
         7LHJJ5l1s7WEKhJPhTnUW/8yo3HajDEpzo19YIq/MnWzfAxIkmrcgJwyU/8EhisitJWX
         aOShvCOG+2knS4OZRo/Zm7Jho7aBmsH/3iRhwy8f6MZWGI6dJ8/EgbbTJrP4ShnRHQXV
         5uhA==
X-Forwarded-Encrypted: i=1; AKwUvByMXT4mzHDRkH29jmsZl3qj75806J80Uq5XuJTkNIXoFg3R3i+aKS8csJR5cxDqzGGLtgM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwfhAYHdSPpn1WWcXGVM0TufqK6+BseQy82dQp8+g7LghPRHt/
	zG0nNMAwLQH7U/QbR5CuAWQKReJqvse1tOwLqWV1azijGhWgCC9bBNOG
X-Gm-Gg: AYBFou2eJ/7Mx0c6KTMcFacDAFAEHZVNsnjTISxabhYt2SGJN+n7yr7k890jPaIGbiw
	AnKYiwL163Z+ZfmwfWykZf2A14oetycgHyupxvr6rk0fpZOCSmM4MXvEvTAwxqnGI7jg5eRkJY/
	XEJ2KO2/fp1Uc24DwKlnA0QYmJv88LV64pXcOTOnDeug5D4Yn+bZVKX1fk4D/FyXEAC/b4Btcxg
	L/O4yKvH7SRKQZJLJZXE8Frio2XoHxbzC6eLtB3dfpXbOmYHC6kWt+4mXysN8pYxY3ESwR6CUyI
	67XXc3+trZFMwJUIaPSeUafJDbQWA+r6bGtNtqG8gsUwGwz/ym/JvldRPwwKZUHmxVUvjMcD+Co
	Q0tZWvsRRCGseV4+jk1PLQuZgLBuLzkvHhfyJMpdXCMXjMA2MxlK/x/8xm3EsYwgeWFDKSfrFMd
	LGVYc2OjYQO/HaJFyz0tz6zoaVppnTG5Yflbr8oMtZq8VU5IcGkCzsfNoakQ1LB15ANV6fjuDrY
	VG/9eJUo0bnMyGFx7vVsRx/ugmg9UDqJQTGhjRjY2irnxD69j1/9KW6hb+ryQ+o1e1lzFqEoeC4
	m1Z6v8Sl9BngL9VYEg==
X-Received: by 2002:a05:6a00:3e23:b0:8a0:5dd9:7983 with SMTP id d2e1a72fcca58-8a2c626dc87mr2265345b3a.12.1792770541818;
        Fri, 23 Oct 2026 08:49:01 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a338ef4903sm149223b3a.26.2026.10.23.08.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:49:01 -0700 (PDT)
Date: Fri, 23 Oct 2026 17:48:48 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Fix out-of-bounds btf->types write for
 split BTF
Message-ID: <atuB4OmqU8CsyDDq@gmail.com>
References: <20261023063133.563998-1-yangfeng59949@163.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023063133.563998-1-yangfeng59949@163.com>

On Fri, Oct 23, 2026 at 02:31:33PM +0800, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> btf_add_type() bounds the btf->types array by BTF_MAX_TYPE, but for a
> split BTF the type ids it registers are start_id .. start_id +
> nr_types - 1, so what is actually left of the id space is
> BTF_MAX_TYPE - start_id.  Two things follow from that:
> 
>  - the limit check is an equality test,
>    'start_id + btf->types_size == BTF_MAX_TYPE'.  It is evaluated only
>    when the array has to grow, with btf->types_size == btf->nr_types,
>    and the growth (T' = min(BTF_MAX_TYPE, T + max(T / 4, 16)), starting
>    from 0) is clamped to BTF_MAX_TYPE, which it lands on exactly (...,
>    928143, then min(BTF_MAX_TYPE, 1160178)).  So unless
>    BTF_MAX_TYPE - start_id is one of the 48 sizes that sequence hits,
>    the check does not fire for a split BTF at all;
> 
>  - new_size is clamped to BTF_MAX_TYPE instead of
>    BTF_MAX_TYPE - start_id, so the array can still grow to
>    BTF_MAX_TYPE entries even though only BTF_MAX_TYPE - start_id type
>    ids exist.
> 
> As a result nr_types can reach BTF_MAX_TYPE for a split BTF while its
> type ids have already gone past BTF_MAX_TYPE; a type never validates its
> own id, only the ids it references (btf_ref_type_check_meta()).  At that
> point btf->types_size == btf->nr_types == BTF_MAX_TYPE and the growth
> branch computes the same size again: it allocates a fresh BTF_MAX_TYPE
> entry array, copies the entries, and the loop is left with
> btf->types_size != btf->nr_types, so that branch is not taken anymore.
> Every type after this writes btf->types[btf->nr_types++] past the end of
> the array: BTF_MAX_TYPE * 8 == 8388600 bytes are requested, so the first
> such write lands in the 8 byte rounding slack of the 8MB allocation, and
> each further type writes another 8 bytes beyond it.
> 
> Fix both by bounding the array with BTF_MAX_TYPE - start_id and by
> turning the equality check into a '>=' one, so that the array stops
> exactly where the id space ends. Base BTF behavior (start_id ==
> 0) is unchanged.
> 
> Fixes: 951bb64621b8 ("bpf: Add in-kernel split BTF support")
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

Reviewed-by: Mahe Tardy <mahe.tardy@gmail.com>

Indeed taking toy BTF_MAX_TYPE = 10 and start_id = 2 we can see the
array can grow from 0 to 10 directly, get filled, enter the growth
branch then the condition is for E2BIG is 2 + 10 which is already beyond
10 and thus never match: we re-allocate the array, copy and write out of
bounds. Fix looks reasonable to me (but disclaimer I just read that code
for the first time).

> ---
>  kernel/bpf/btf.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 80b6f96263f1..6e54cd6c2eb5 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1724,15 +1724,17 @@ static int btf_add_type(struct btf_verifier_env *env, struct btf_type *t)
>  		/* Expand 'types' array */
>  
>  		struct btf_type **new_types;
> -		u32 expand_by, new_size;
> +		u32 expand_by, new_size, max_size;
>  
> -		if (btf->start_id + btf->types_size == BTF_MAX_TYPE) {
> +		if (btf->start_id >= BTF_MAX_TYPE ||
> +		    btf->start_id + btf->types_size >= BTF_MAX_TYPE) {
>  			btf_verifier_log(env, "Exceeded max num of types");
>  			return -E2BIG;
>  		}
>  
> +		max_size = BTF_MAX_TYPE - btf->start_id;
>  		expand_by = max_t(u32, btf->types_size >> 2, 16);
> -		new_size = min_t(u32, BTF_MAX_TYPE,
> +		new_size = min_t(u32, max_size,
>  				 btf->types_size + expand_by);
>  
>  		new_types = kvzalloc_objs(*new_types, new_size,
> -- 
> 2.25.1
> 
