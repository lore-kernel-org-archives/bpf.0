Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB555280023
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955309; cv=pass; b=Ry/WPSe8sTLMnyKEGcW/VshwJZNfxM5ImU+F7bHhU+9Jaw7cwu6tkkBAPOu164Ak/l3Dw5XNZoGRY2dIFnB4O3nXWGTikhlysDEf4UgB5Jim8ZIV3lzKGaBNGGdOGGW8k6T2JGQ8BVQuAPtb5I8sd78yBKxewoOiMQH+ZbUsGXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955309; c=relaxed/simple;
	bh=ykwRyuIkN7dQxXWoW01+uvJ/5EsJIeCfEW7aZ9T9joQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAXwSnRxJjqDadx1NOqmE9aIkTJjL7M1A3jJy403HzOgVc5DGVfLtsk0adB3irq16v1TOmak2EMtjh0qbP8GfkUWl9TWaGxpKBZ6A/c54EjoslWnhQviuBy7Ptxd0cfqcW3TUAKINBtmYh+4pKbgXN4Isu4k1IdYOrCxw/R1jfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAKET0xI; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAKET0xI"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-432755545fcso3446111f8f.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 16:28:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768955306; cv=none;
        d=google.com; s=arc-20240605;
        b=OK3MaYl/Wz6B+XCNHJhvTzXM8ZBjiUsBBc05sGx6QaZMksx8LgOA/nzcwWOlIpaGcU
         UsgcfoXkW6vO5jjiwnDtaBgYBiDEUZ0aEQX/MccXj7IYJ9Ri7jQ89lCdsSYMbC4ktu7h
         KSpmh50nTvjy3Jo3eL8zU4StXOOzTNjE/N6oIwytLEVEjOKfbLsr4Ab4XVX6tt4wh3JI
         SGGRiZjdq8V0ZD9K5BbqxMPJdb4lvuMdVt6pn2NGBmEI4bM+kouGsB8VmN721UnGng00
         NKmoSZ6IUBBTPyWXsSMnBD/AirSka0fGk3RhuayjG41yWRceuTG8dBRpWBP4b/kp1Qg2
         cBfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YTxxZRuya7/Gi3hLrrFK3AMW7Li4wzwhrblZHCa6ZEo=;
        fh=TbUvYbUQjMb4Zb05UtLdITPFTjUQMAlLW5fPY9bAVCk=;
        b=S2tPiL6bSJyaYtawOg1aTQ3HDf5hCTJ3Q09rR8fyvnGlAbeBGPQyQ+FYVtQg/MJmiS
         3h9MfFj/nNQD6MOJMM/ibzFwS5ZdsHkZ0u5F+kQKYrbVQrySeF4JmF59OYzBVqSI8rvZ
         XhF54+70UCRagedcQ29/O76tpGGnHVkaQT7yuKZt1AGNqU5ZzuEcPDyyy2fIAd0b4YqF
         KGnuSvDlLJOiN0oxrSWlDPXd5EqmZAyVEHjd8MeO/elrV2yVhOYznCkR+mQAivU4CU5p
         yrFnvghxN3PxRB4uzjxV5PGCC+Jj3SpNUr2uy8HqlEK6xdQ4a8cVgYU3pqgQ4VxQFSsy
         RkEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768955306; x=1769560106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTxxZRuya7/Gi3hLrrFK3AMW7Li4wzwhrblZHCa6ZEo=;
        b=PAKET0xIKck0bjYWDLDOfrCDlhfgRtKYNope12YE57MqMd/nY8Cpj/lro1f73nLUF3
         qpim06VjPGRECOeZKshBefDaekt/zXdGs2CwvwKuJNhnpN9c6BIogUoJz4WhT4IXD4sE
         TZ6RKkgtpMyD/rvVXKoQSJ56p9x2E1ocP9upqAQvsd7W5mE7CgCvdQvEYgKxeR++bqAG
         kEkbDJgtYsK5uT34GCJzisLT2fYc3PnMx2lHDMklPuN+Nb+nEUNaBeLiSoCulpbZktLR
         jduRvz+KR6i7+NqRtexK8TrFb1+nOXD88Py2rrPginAFCfoBqvC5QoVyKJpUy8LRtoiJ
         5QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768955306; x=1769560106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YTxxZRuya7/Gi3hLrrFK3AMW7Li4wzwhrblZHCa6ZEo=;
        b=ny6NSmB4tDr9Ioqu4uSSLt13lO0mm1lIhwga3coxpA21PWETSYLL0/9KaFaRmqJS0t
         KDCvEpcZWj38o5tqKA4m/BYzjJs0pIEhqT9kEotWk9WGIgK5pYz/f8nPtliwgU0eXju/
         lAVnQ9jR0bRDvshd0KxOnR/zEEdUkDRdadPMAnyOFhF6psHbfc+hPDDce5LdL8mEcmoE
         fTZraimz/qBns6Bj6OaZ45au4uC92CH16j1tgpzFIMAHYJo94Ocr/ALMn8/WBGBUyRy6
         D+USE1xMOsgqm7zeAY60WBZd+NK0JG0YrJkmcyO+6uz2yz+WvNFlak1cRltz9tMmc+go
         tC5A==
X-Forwarded-Encrypted: i=1; AJvYcCW61btB5EMk2M4KedITQu2XFpxnzrqr7oedui3KFwHpvMr2Wf4GVGABRnjphto2gzkDEW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjXvgt4H19peZdmHe2dwBHveo7b22CYzRsKsdm3XnmkIKjwDNO
	pOGdXIzempSZ84W1BF1KW4dnHzGDh46MrRrOVViuuOPMQkIhQgln4qt0Fm6pWKzFNLbO2CjCdyE
	j3fSzG7UohV49r2g9G9SFRODHoF9eBD8=
X-Gm-Gg: AZuq6aJyKLmrQ9LyAM7jFg6MMm+9TJZWVuieKfR9NSCQtGp75WgjOiYz932Uh+KRLTO
	zOMwPzOuqQBLy0AVXxF6qLYl7HDGh4g0IfZg5t0RLwK5ZzdD3E1d25wTKIWePe57QSzV1u6RzBq
	ZuEkdtXcHat+1SHSPuBFQhK3HZUm0lm2glG1npmOGVs8dv13ZinW4V3vnJrnOA+Ooyq13imN8mH
	AO7EtAfuIiA3BIcHkGp5A9vbyS7IA2h05DrJ70ZdCoKvud5g40utIUVBlKsEYO2KrgJ2ZLsxKTN
	VQeE0Ntpmctm9mdU0cD+n8Ez5Dd5XrOHNWq21kgcuOguuG/sMz8OwVYQJ+kc2xjx8QsRmeYy0xb
	hz4QdqIsTvFxCkQ==
X-Received: by 2002:a5d:5887:0:b0:431:2b2:9628 with SMTP id
 ffacd0b85a97d-43569bc791bmr23387063f8f.52.1768955305540; Tue, 20 Jan 2026
 16:28:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120222638.3976562-1-ihor.solodrai@linux.dev> <20260120222638.3976562-10-ihor.solodrai@linux.dev>
In-Reply-To: <20260120222638.3976562-10-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 16:28:14 -0800
X-Gm-Features: AZwV_QirZ7by-RSgel-23msL5t8z84yNv4bEqKzD1qVtVLw3zvjD9Oq_RbOOeic
Message-ID: <CAADnVQLm7kOxTa47POtNGYcjHm-S3neKWKAgjZL_5uw--syMCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 09/13] bpf: Migrate bpf_task_work_schedule_*
 kfuncs to KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 2:27=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
>                 return 0;
> -       bpf_task_work_schedule_signal_impl(task, &work->tw, &arrmap, proc=
ess_work, NULL);
> +
> +       bpf_task_work_schedule_signal(task, &work->tw, &arrmap, process_w=
ork);
> +
>         return 0;
>  }
>
> @@ -102,6 +105,8 @@ int oncpu_lru_map(struct pt_regs *args)
>         work =3D bpf_map_lookup_elem(&lrumap, &key);
>         if (!work || work->data[0])
>                 return 0;
> -       bpf_task_work_schedule_resume_impl(task, &work->tw, &lrumap, proc=
ess_work, NULL);
> +
> +       bpf_task_work_schedule_resume(task, &work->tw, &lrumap, process_w=
ork);
> +
>         return 0;

I removed extra empty lines, since they don't fit the style
of these tests.
While applying.
