Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792561626;
	b=oVIy3hQOgntMZ9CPZ2Ll+rB+vX5Zr3WWT6CMvFpaPBNJYh1AjrzXPeFZ+zbQGpGlJj/O
	 /4kLFbu2ZJIlWuhXyLPMW0gt2ydjZfvmFuFHI+/CGscskSXxXiJqOh699+S7jcfKKNnJb
	 b8aebnH4A6A6Onf+Ex0AuCw/fDA71JRJvSlOjPoB+6sh61YnYwqVTLYdptuFZ/PPYjXxR
	 pCsjybi2EnrADwlwxGcVrwKmwrljVjv9radxKJoM2VLxq5SZC1dNV1BOA8SnxTwQeVqDO
	 3uRuD0zpZzfA37Z1M2N7rGUzgpl0piok2xs8Nsf/3U9v2+TiZPykmrb7nXJEzVNHhdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tSn2dX29VgDqk2hgfuzvCjkC5Mz2yIfzdQjrFRKGhV0=;
	b=KG8v+4Zu4zB5zXlbOIk5xpBwgUxEsXzMOsv/0VquypryGIO0fl+XRsJNM1fxwAQNJEtp
	 owWhtbB6tDkGsSsL34YMWUac90Gki+F1wcEtbuziiRidtRTDPHgwRVqPHhTlF8A3w0Pus
	 AsrWKf0ALV5xb7XeYsFrqvlWFNtYlAq8TPCBfbPzv32f6swiywR3RMQpVvx3KHu6xcoBk
	 Ww5uhh9mj7CNpkLdvkpcZfpb3H9o8atPs4ewwo0iGByIimXSfXeHNg62mPAC0wBtUc8zP
	 k1/W08XbvbJnwdTRPVaq4VRZ8VXGRXu5NJaU3FNTS8IzW+hpSUN+d6G19iByrVqngjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PPORQrRF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22159606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 05:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22159606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PPORQrRF
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-679a420b5afso304497d50.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 22:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792561625; cv=none;
        d=google.com; s=arc-20260327;
        b=OkyL98uG9rCoYv9/eF7x1oHNRUSqhxIuoZJv48hXaEGnL+lPN/9oRrnCeQKBYDSjLt
         yUulP+dJeoluwGqD8V1fIiYdPYkaVYchwk0ZXEXAqagVu8L5GtusZg0/Fy+VjcLbpJH9
         ExZOE/iEDFhcNNYc04IxAztGfnJ3VsjSqBuxB9spco6syvhZNuW2q2uRGRan8Qstjoly
         aesHfvCFU25Nk2HK0/vQpphPGD3sma/f3WJldt4DOJzjwYhZharyMUi7JxMbZzV5E38j
         BJuzFDgeXI8aZ1Yljfj+RAdQ6COzlequHXzf/Qas0Ldjzj4vVqNT9Pu1sknrBicimHoM
         ZivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tSn2dX29VgDqk2hgfuzvCjkC5Mz2yIfzdQjrFRKGhV0=;
        fh=VTRlYsIGODNflk3ji9MJVAq5OOsKeiKXLRRUxV9UpYI=;
        b=j/9zqWYeZ5Z9ENMldYMQaXujETfdpO8fO/b/pRmewP8icgNeXW3b4CbJ4HpgRuKSzs
         hKukT3hwbH95522BO3xAyIClbZ1Seojz4uE2EqfzIAPYoqJLi8EMIVKk9l98tOEAc/6I
         7fubAq+TmM/ZTTC5uG38sETiwMXIIq/ssvSlrMN5iB0qe00snGp8UHzXUtXr38XUcdU0
         KCCGN4h0EpsJVj218oNFBEaTbHj+dRPi6USMolHowr0Cth2qUEYvwTbK9TgytibKm1b6
         h0W0PBxwqLr5NK5or1k6zKSdgivMbT6faevBCFa5j6KwXRrX9s1L7RAduJVcBAP9ZDoV
         lwWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792561625; x=1793166425; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tSn2dX29VgDqk2hgfuzvCjkC5Mz2yIfzdQjrFRKGhV0=;
        b=PPORQrRFn7tZ3dUbqNotr7EMNnlKNVNCXlWCGZrOyaBVAF9EWlt496mVN9F89V7iIW
         Dgvr1ssi7Vixkf1DCoN0fOT8+ZVAK9fR5LesXxVuAcuXDQAjK40EmYAPUVU/21thJ4AU
         qvkAx7aSPuCZk8yRSQLOl1PS3sGcsFbyuZ1+JqblSWUrGt76EBa4/gW6XVdzBs7oqjam
         CbJzFige92dXRxMnPYrygO/mjvUjCCb1CYDB44/oE7PwgidEFUdRT2fzOfYRRdzwIMxR
         gsWyk0zV1rZLN5BHtIbO3EH+G5c0ZH/VtiIdvXbunKzIW3vbDrZ108f0vlFgOnu9AJXw
         c6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792561625; x=1793166425;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSn2dX29VgDqk2hgfuzvCjkC5Mz2yIfzdQjrFRKGhV0=;
        b=j9T0eqOz+Z0ErHBd86YeWZFD0J4EhpbJahKHOeJowWCrtzR+JefxsoayF3/6DK71wL
         JIVc5x414QR6eU3L8ENsg9Zbpq04NRovcjg16M7SNz+cnNNWL3oBI9x/qV3SpUzypPrB
         E8nUGSo0wd8j41ebdYAZgDjZwc6O8eESi/O5UxW/ou6YwISbeJJo5S6U6u6BC82B8+44
         R+enbiRULf5NPH6c8GtdCK0gcMq1g/Mj2dr0Cf+EZzuk2Dt78C71P8YIFsd5raug9Ul5
         akg1xpwCzfseXYbuDrGKtVb+S0tQolf35fIvipaIF2Kk5+Lf8nWW4b1zRSOHKMEEsLyL
         bLGA==
X-Forwarded-Encrypted: i=1; AKwUvBzViBmPU9d9sm4OLiA8o5aYUkqMZojDjHLrv4XURzAOQ/eUjWRAox2Vdwafhrh5KzrFjuw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIhCRnc6YcwvhmM6V0kq8L6TYDdZ4ERic5w7GZDFrbgFwbynEB
	MdZTVaQcZ7c3cwbuzmiEo8+QdfSTRbL8a61d3OIzjkcykjqkl757qHUZ+5wmeTLn59AQ4aX1u8B
	y/xaMc+50lU6yXWhQ/8UdFG9HBwdWay8=
X-Gm-Gg: AYBFou1PnndtbP9mPEUPy5GJC1YCLXkp/huaSKaEf3zW8FqNC7AbRGxvSBoh2yJEEA+
	TgtSXYA5dOSQAsGe1fdEdO7x8j9QYn6Ybu1WJlja/OzjBLGrVuSIaaFfsLFl3/GwXwlVUTrz5ft
	dpa6Qr7AQWpeaARxDml/pJNKui6Ab9NWfPaFP/6IH4Tqtx6hEiaNav86SuDRBjyvDje0EWPxati
	8O4UqHZN+RKPj2HydVQwtAwqF6SsDSgAZ03H143t3jn9N6ahD8i8MYayVXnbnT2RT8eS8x8jHAQ
	zKEL1IZ3RbwBNY9c9f1d/qmrNtqZnMS9y+4xpgk9fSYM9vn0BEEPa3hzzt2+L9rkJuvpo1PT6Zd
	LFzFHoImF4hUsmVEyYx5TiLId1QGWgAA4KtF4MQAKVi6Vr/bnax9IPg1B6J79QorTBdmcBjVZ9v
	6Ys6bt3CuTpYTF
X-Received: by 2002:a05:690e:4390:b0:677:a7ac:5624 with SMTP id
 956f58d0204a3-67a0e4bbea1mr386088d50.44.1792561625107; Tue, 20 Oct 2026
 22:47:05 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019064157.29885-1-laoar.shao@gmail.com> <20261019064157.29885-2-laoar.shao@gmail.com>
 <179254940965.1919196.7604748267690139512.b4-reply@b4>
In-Reply-To: <179254940965.1919196.7604748267690139512.b4-reply@b4>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 21 Oct 2026 13:46:28 +0800
X-Gm-Features: AclHuK9yUw3q9bz6eHz4oS9_OplikvSYcNJ_NBkBIXr9uF4A9eTzN6CgKR5Bujk
Message-ID: <CALOAHbD_1rRWk+T4JU9gbQpjCnf6FnKmnj70U7G7CgWXdp61EQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 bpf-next 1/5] sched: fix stale get_pref_llc() stub
 for !CONFIG_SCHED_CACHE
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	david@kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, yu.c.chen@intel.com, 
	zhao1.liu@intel.com, tim.c.chen@linux.intel.com, lizhe.67@bytedance.com, 
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 10:23=E2=80=AFAM Gregory Price (Meta) <gourry@gourr=
y.net> wrote:
>
> On 2026-10-19 14:41 +0800, Yafang Shao wrote:
> > Commit b636fef85bda ("sched/cache: Introduce task_struct->sched_cache_g=
rp
> > to fix UAF") switched get_pref_llc() from taking a struct mm_struct * t=
o
> > taking the task's struct sched_cache_group *, but only updated the
> > CONFIG_SCHED_CACHE definition and its caller: the stub in the
> > !CONFIG_SCHED_CACHE branch kept the old mm_struct parameter.
> >
> > Fixes: b636fef85bda ("sched/cache: Introduce task_struct->sched_cache_g=
rp to fix UAF")
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: Chen Yu <yu.c.chen@intel.com>
>
>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>
> Please submit fixes like these separate from your series.

Thanks for the review.
I will send them separately.

--=20
Regards
Yafang
