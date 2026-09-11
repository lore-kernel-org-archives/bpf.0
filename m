Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C33A7D73
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120403; cv=none; b=cs4sibYsTs+5Cp+716VRRLgIZf8/LIKmDbMHKTdr2/xchKW5FZvk9Zuqu976pzbfgbag7m5EeDnjxxcentV2HcA9vYcMdhZY737BHCIMK/oDCTUUFrSL3kMg0JMbvmGZcA36Py+5D/bQoQWFyPQwTJmNaQ0XwmMv3okkteiJ1NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120403; c=relaxed/simple;
	bh=5W92TlywX+R5WCObWv/kGX/hST6LPx/5MCVw8z+toPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jth+l7px0jBScTW2Tw7kEuDCZNSxYF9F48AvTC+fgK6z4Hpjn+FqBmiFsVWztXJXJ87zSa2K0fJaT2n5UIii27eofss+7as73G4FzTZgnYtAqo6rVv4YJhgD3iURqyR1lLHYEfr0yYf7EGh4DoCmBb07rwGlVKDvtfn1WLEHrjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lhak6Pkr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdotVWtI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lhak6Pkr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdotVWtI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789120401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5W92TlywX+R5WCObWv/kGX/hST6LPx/5MCVw8z+toPk=;
	b=Lhak6PkrXex8ohaXRSmlhXX6xtH/s9fRLz7+X6BRB6fJl8EnDRXJHGIPw7FxEfbKGSkkF9
	fWQYdyjieznDKj5Fr1V0YDUkL0jFwJokmQNOqGeiFnCJMb3sWp/av4etBojLLHCVmhO05b
	/0QievtyDUhPPla+Zy/l9XlEBtkwD58=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-cg1b13R1MBy00t7OeQgQ9w-1; Fri, 11 Sep 2026 05:53:20 -0400
X-MC-Unique: cg1b13R1MBy00t7OeQgQ9w-1
X-Mimecast-MFC-AGG-ID: cg1b13R1MBy00t7OeQgQ9w_1789120399
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4839f9edb08so370832f8f.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 02:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789120399; x=1789725199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5W92TlywX+R5WCObWv/kGX/hST6LPx/5MCVw8z+toPk=;
        b=ZdotVWtIPpFntTMGMHqNYmhC7e1wfNzYj76pJPwupRoRinVoUa7aPLc2pT+lsyFSxW
         aFSvyaR4kUzzPyhxuPQMJhM1FnMqdAmLu4dwfwQAnzkj6RH4jO3dotpYV5VMmCfx5Znq
         edNcM/HKWmkujll0MISg41JmundXTxTX+STRW2FRpAm4jUa/oiJKPCAzCW2slztkozLI
         1lUe69jnKhGR3HQRRHtCgXbqTIr/K8b/Rl3MiaJk/rOvB7z/zvez4HQFGc+iGXDouw3u
         KiG2fgvBwe61QMiFvFC0YVuVRfRggeLBvRpvq9sZvleKd6/0/+jXSq0qU2mEMRh6ZIQ5
         01gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789120399; x=1789725199;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5W92TlywX+R5WCObWv/kGX/hST6LPx/5MCVw8z+toPk=;
        b=Ujr0Ha3GFiJpDOgk34JGS/7cKeg3gGIPE46ut2cccHomfy7xRJzQOQr7TYOf51HP0W
         oaQvrsoQ/n+mldwXvqftMMbL9Euko7P0XAQDWyMk5SGejSj8+W1pxE1uEGlpr4XhkahY
         ZKVrG6ny6ZvuS5tWxCzlYw1s0lXE0ETajQ/pxyyB7j4IjSWSAmdD3GiqUCA8I2+yTPdN
         JeLrAe8xJVT1pNgUfPAR5kecc0QP3psMGGzobWU5q90D6vsHilRExmtsX6uRlYgCIoW0
         s7pt4dPjcKjzYqt1AuO7nK4YnqHe2AIvuHSECbIHkvUeeLBtaVfuN/hI72v/F/mOiQzs
         TeYA==
X-Forwarded-Encrypted: i=1; AKwUvBxX+ZS2G2rTy/J5GoYY/3pZMCDP6rbDAfRpRoe1tSR20F4Ek0AiBVieqetvViR4XDQ2sp0=@vger.kernel.org
X-Gm-Message-State: AFuF++lFUeBdbiWuhiZrKWxroUqqfc+6fq3t/laeWyF1CjDoLWj0VTSy
	s9Xy+V2tyL5ZDowbmS5gg/0OMG4xBRmNiY9aogOSJlDt7R+DGyZSQsV8AndCWjftz9a58rnObUx
	AFQHcEeJGAEbR1KR6f8szjjFJ14LKDZo6TnXBCFkKMsBbxr5hYn1djA==
X-Gm-Gg: AYBFou3BxxCFvDv971aA8vOCmp0EWyGHwUoZp6FPUK4T4Qxoqx1Nx5mGm2t73fvSLcv
	R7VrBzB6F0/gjap45+VXsNy3C16hyDuYR7sxxJOr8NbasePKgrGfF4DXPYyPqnEnAipy4T8ujpQ
	WSMdMxpBaAA/YWD0lL97UgjBfK35ZbA63sI9TKUWcJAZqknyvrOZ5s5GsFe76k1uxoOM3cyr9GU
	8R2j+J1S87WSeBYKif+5BcwxysbaoqcjmBLmqLEtpVJ81gdFUS8+vl49Ez4foD1l1vPy3TqxaR/
	VVTBPFknJoiSvvnwWWdoOK9y/F0AyhhJKdT0UkYq9zapGHJASesqUwPDcqAYxHXVDjdD+3ghEtQ
	Qeg3ne6rSV1qSaIic8NkXYJHi
X-Received: by 2002:a05:6000:471c:b0:484:3317:a19 with SMTP id ffacd0b85a97d-486eb2ff57dmr3413187f8f.26.1789120398968;
        Fri, 11 Sep 2026 02:53:18 -0700 (PDT)
X-Received: by 2002:a05:6000:471c:b0:484:3317:a19 with SMTP id ffacd0b85a97d-486eb2ff57dmr3413148f8f.26.1789120398603;
        Fri, 11 Sep 2026 02:53:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ee8bsm4693194f8f.15.2026.09.11.02.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 02:53:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1FFDA9B9976; Fri, 11 Sep 2026 11:53:17 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Adopt
 bpf_program__add_flags() helper
In-Reply-To: <0e8f9a9c-6295-49ad-b29b-84613dfbfd65@linux.dev>
References: <20260910183222.307208-1-toke@redhat.com>
 <20260910183222.307208-3-toke@redhat.com>
 <0e8f9a9c-6295-49ad-b29b-84613dfbfd65@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 11 Sep 2026 11:53:17 +0200
Message-ID: <871pb0dshe.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jiayuan Chen <jiayuan.chen@linux.dev> writes:

> On 9/11/26 2:32 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Adopt the newly added bpf_program__add_flags() helper everywhere the
>> selftests non-destructively modifies program flags (which turns out to
>> be every use of bpf_program__set_flags() in the tests).
>>
>> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
>
> =E2=80=8CAI pays excessive attention to wording.
>
> maybe just delete whole parenthetical notes=E2=80=8C "(which turns out ..=
.)"

Well, the two instances the bot is complaining about turns out to have
been added after I wrote that commit message; I didn't re-run the 'git
grep' after rebasing for v2, so I didn't notice this.

I'm not sure if those two are candidates for conversion as well, TBH. I
can respin with your suggested change to the commit message, or just
convert those two as well. Or just leave it as-is, I suppose. What do
the maintainers think? :)

-Toke

