Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8302935E93B
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782166693; cv=none; b=L5jWsb49RUAfqlBpsXKIP7RPb0zXZ5pHaMcQLbyQPId3CSI/Qez76ammR7bN45ZFeye8sXuriDLS43z2ryz+hbIAlLMvr8HjUHl0nOoKbeUZUmDQlu+DzXyCVTjrsdvU4tIMnM9KhRkhK2J/5jBDKiBdE9WVAGvqeSdUbj/0iGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782166693; c=relaxed/simple;
	bh=F+WvLAPFUq4CsO1J8qQc73e/7yEQHb6nkh1NebCvdj0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EL8le10bd4TuULDA4GtHCWmU8zyPEEjHA2DgkDbYE5SZ8violYZzyG7aEixsPMtzMrTEh4iqw+fS6TyvqKA/JJM8U6DM0VphmbrY1R1B3H/+xvrn4oI6Eyy/xUISVssHr87qqElP+zuJ2RYJ1ca8fXiKtwBle1fVekTnkGoIBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFdgatKH; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFdgatKH"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30bf132969bso6179261eec.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782166691; x=1782771491; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QGAlEGkbclIf1aPKOGO3sDSKkWTowKno9rwGygy/TtU=;
        b=dFdgatKHuRNAhVbLGpouyir0qMploKOxyiWP9XoDB2O2AXBNoOZ/vK0pV2OqU5lO7y
         wO0fJsC85bCrepUBNCj2BydjmzOP1XYveXi/3VObw604xRvxx+HvFpVsXJTfC6hyGHZ6
         sienmX9STPbpzdHzEYMRZqFUTdP6yO+1wN48aZacHkWtMlocnXdq0bW6ibEkk+r3vGET
         CtpfhZ9hPatgMMRLHrTPAAioLMSmR41dLnYXE7i0hqF0Syp05uEK8MdZ0VG9No/Ay7wW
         w2SxCFoeTT2CE1Gl/b9JhwJT5OSvr+HAbLc74GIiuSjT/LRWnqsY3JyguJQeLaYKy/gb
         5JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782166691; x=1782771491;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QGAlEGkbclIf1aPKOGO3sDSKkWTowKno9rwGygy/TtU=;
        b=q+ICZd8WsJargqwYWC8V0QQBmTtwH7zqNzIuDQjF8Q8o3tzy1oe8BeZcJ5+lHHSTtW
         RAO2swnJwpNqYcXdWdKEKvGG01ZVX5ZDBZpi2bP9Tc4oeTI4TjjpA0e9eoQlOdnUVgPN
         n36vDDYiZ4uMiWaxRWhtASTXl7/FQl03NgC9YylWCXz3OqCo7iJSTHXJFZTom3qqMn4z
         WX4wK+3B1WdCwK9CETusl64tD87kDVT4atS1xmD4gkPoKKwAK1qk3mqUOT4Hbmcp6Ryi
         T5hWV+DWEg7PfmWR1llqbzalfcKWSGTULOTWeG37T0KyGGuZsbEpOSjkG1ykwr0/LYXP
         wing==
X-Forwarded-Encrypted: i=1; AHgh+Ropg79J+TKoKDpCzN0rFPwYvEEuai0DzszqkVC8AGwD44v/S4MUgZtimkOYuapX4Kvem6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7AJenxH4sCBjpuqKGAei+x19+dKgcndRiFla8xxTsLSfE7z8
	W+EVRKT7xGeqXudUaDJ38jN3+mM9YYd2+Jt5t4vHTNapJexkNgdPtzF5
X-Gm-Gg: AfdE7ckjk1MHhxZl8OcOuxYzVJ0SyvV/t2Rsb4UMAF6ea58wepFi0cMxx59O5nyZhYh
	8cDBiI1b4C8etVbij6QIQgfpDaoFt/DhJN6GcePNRlc2b16wEAeELWVVQ5fJqz6xQjlVFDIaSpv
	WKysf68CoIr9ckPt6G1m5hb1G/+THnkaHv8F2akJBjVDWa7Esq+TxkoLX2g4jh7iwYvRzS13u5V
	1ytpqqJvsII10eOzc9SQ9cVftHlVg+UaMLWUA8YSfoQTAHgKuTgVxTDXhfvMCbBQ99l5uP4ihW3
	i03TBJD/mUTSZ2JYP3gaUSlOT/g0DawQmM6UyP3FU0JEdVIIuKfKWa9RPTKPwg5Q/fasnt67R9w
	g6TfOwaxC2pm8238WKG/dGg/RixTMHfKVh33YndInyZmMqPfxY2mcZ7SXJ0A28JVmJ6aR+M9JsA
	f3xkCl6n9DjXohpPLC5qT30d+UfHE41Yw9io4qiu/iV8nn95M0zX1iljUZpbRXD+B+vufsTg==
X-Received: by 2002:a05:7300:80ca:b0:30b:f3b8:3e7f with SMTP id 5a478bee46e88-30c06fb6af6mr11568152eec.1.1782166691510;
        Mon, 22 Jun 2026 15:18:11 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c4f4:7a34:78e2:a600? ([2620:10d:c090:500::2:e8d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba8fb35sm15020973eec.12.2026.06.22.15.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:18:11 -0700 (PDT)
Message-ID: <30dbb3100674123393449f76921a952127c21588.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Preserve scalar zero spills for
 var-offset stack reads
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Woojin Ji
	 <random6.xyz@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, bpf	
 <bpf@vger.kernel.org>
Date: Mon, 22 Jun 2026 15:18:09 -0700
In-Reply-To: <CAADnVQKTMkHwnZb-VjCErqmoe4O4=aT1vjMU8XcZiWpNG-LhVQ@mail.gmail.com>
References: <20260613-bpf-stack-var-off-zero-v1-v2-0-a324af0f00ea@gmail.com>
	 <20260613-bpf-stack-var-off-zero-v1-v2-1-a324af0f00ea@gmail.com>
	 <CAADnVQKTMkHwnZb-VjCErqmoe4O4=aT1vjMU8XcZiWpNG-LhVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-22 at 14:43 -0700, Alexei Starovoitov wrote:
> On Sat, Jun 13, 2026 at 4:16=E2=80=AFAM Woojin Ji <random6.xyz@gmail.com>=
 wrote:
> >=20
> >=20
> > Keep fixed-offset stack reads out of this eager precision marking path,
> > as the new behaviour is only needed when filling a register from a
> > variable-offset stack byte range.
>=20
> ...
>=20
> > +static int mark_reg_stack_read(struct bpf_verifier_env *env,
> > +                              /* func where src register points to */
> > +                              struct bpf_func_state *ptr_state,
> > +                              int min_off, int max_off, int dst_regno,
> > +                              bool mark_zero_spills)
>=20
> why differentiate fixed vs var-off with this flag?
>=20
> It seems the fixed offset reads would benefit as well?

Hm, I though we handle this for fixed offset case via the flags in the
jump history, but apparently not the mixed case of '0000ssss'.
