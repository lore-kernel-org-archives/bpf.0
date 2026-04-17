Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7735AC31
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776443946; cv=none; b=SX52qEstiHPAB77wYI3pJedtasC2CJmg8hXF9BwmWEYnWz7PFQ6boc5JQ/NJ/WRMhGGWv2nGaigbhLd33NokzBXx1sLMoG/KsAeV6sszfpZbZF19fmrwqWk1wBomuoWjOBhraF6e+SzYOVyvIkSg0oA545vUZC6yhyh4fcyZ9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776443946; c=relaxed/simple;
	bh=z72nNl0QhPVQbmkHa5SYHjKDf2d1zY9815cIPZMJntA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=M3c1rMZ229ZwDTDfWsuVbaU8ya4hONrPLd41dBHco2ZHgkBCWhrpst7dge7aXJxvaczykScJ+YvDNpH8OzaM4JuvmedvTnRS6Mq1RHh891wPZJ9eEdRDktlqDQo8cH+40wRmfTDp/J0pljouhxDtRMtB8UY3aRft0YBeV1gzk+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=aYOWyidz; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="aYOWyidz"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-12c1a170a50so1196553c88.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776443941; x=1777048741; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z72nNl0QhPVQbmkHa5SYHjKDf2d1zY9815cIPZMJntA=;
        b=aYOWyidz2/Ej19Bn5bLl75jX/KnIIgyC8ikAE1BDGOM2iRDY1kmTw4b01nqlfFpUhJ
         bRCw4ChEyFmufY/08XwF31j9Z7FjV1B+0UiPuUfIb3fOxSnHwxVI18VjDAqkGwVLgtZ7
         ZfLrEANwCeONVRZmN/RSC3bqwuoeTydsmoznKMle0cbJBIAQwo3wa/zYQuxBDTA48aoc
         67k/zqcE88ftU4HhHtU3mygS86t+i+iJaBP79SHGe6CyZ+NGM555BDKUNEombvdE1hdy
         PsnU2WUTaXjfRuKpqSlv8gEshhh2aNzEc1PwiMAwak5dKhe+PZjdV77zkZdDduYmB12L
         3bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776443941; x=1777048741;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z72nNl0QhPVQbmkHa5SYHjKDf2d1zY9815cIPZMJntA=;
        b=BPLYVmrOrKWJqdKeI45uqeTr4TMU9boj+SRc3CdVF2MmGGFmcbKdMFLMrycxxTXhro
         onFIvafNHpqadIan+vjlkiSKh7vJUHyjwf5/dTrJpbxUPDbinRM1eccNecKp7+m5A+y+
         kiync+wziOvGUQaLOvPXAUb+DerRm7J4KMsvGZmJr2B6QqU+5kdw9fNVZLtzuRUGnbvt
         dhIzZ8fhGG+omheC51a4G9G3zO9YxoDq5HN4tY9V/LlLYmXZNpIYYkU+BaWfdLgRRU1N
         hE45zIelVwN5EjbL3iC3RvEPnfx06rPrxBnzCQAC9Ig2oJotXX/zqOSoaUi2kYiJsgxm
         7GPw==
X-Gm-Message-State: AOJu0YxDxT8VEaTiRmvsyBT9PfJ+p/lUJMftNJgfqYoVTvhkoWEPqCos
	JqmO15fB4j4I3hN87wdIjXHdwd7u1m8c5yQunDoF4WXNlH436KoN8tYOqD5w3Qj1ZG0=
X-Gm-Gg: AeBDieuFB3ITXlOMo0LOOhHeBkWzixcTPGkrfatJDx5NfRwxAnw9oInmpx+9LRAeAXd
	V6KUlLcsyMSJA1OBRUvOyl7DGffoh2zYIC7kQaFxDS79hFOjLe05VKV5VCCtfgn2MtAOzt29SdV
	F+dFDs+Z/AQ875YTOhiBNa9A0t22u9oDDsD+CgckLGnRgPoF+f9rNeZwIMQOrcnRyN0mD4fNBUK
	VDh5aIda2LQC0XF05Y0Infg+kve/wQPDkNjam5BLm7XxbiJM1A6bvoPZmt9jQG5pc2FloydQZOx
	SOKSwnEYXIPSRmyLsteEAOZdBtkG9HkKyCCo/w/ZIum1io2dTKSR1y+sq/zJnkx+LPfs4l5Llbl
	9GaET98KnpI3EfNswCiXyNj9GdJ/PqwGPTciM8FsAzjafmzN3BbkVr4yua4d5uOUUGwvVu7RVkP
	9N4RlTmI7wZu1TuME=
X-Received: by 2002:a05:7300:3723:b0:2e2:27bb:a48c with SMTP id 5a478bee46e88-2e47883b6f3mr1594096eec.14.1776443940526;
        Fri, 17 Apr 2026 09:39:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::5d38])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a64e5sm2832065eec.7.2026.04.17.09.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 09:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 12:38:57 -0400
Message-Id: <DHVKTIVB9DWW.BU3DZBYQKM6Z@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <song@kernel.org>
Subject: Re: [PATCH bpf-next v7 4/9] selftests/bpf: Move
 READ_ONCE/WRITE_ONCE macros to bpf_experimental.h
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260412174546.18684-1-emil@etsalapatis.com>
 <20260412174546.18684-5-emil@etsalapatis.com>
 <CAP01T75e3XeJ_wmET8Ht-0h6EtAw6TJkTD48ggwOcsrADr22+Q@mail.gmail.com>
 <DHVK4J4P2XO7.3SXVTFDJ27CVQ@etsalapatis.com>
 <CAP01T77P96yW4Fpfw2PDEvbZ1yGMMyrSEa3+k_NnN7X6tS6EsA@mail.gmail.com>
In-Reply-To: <CAP01T77P96yW4Fpfw2PDEvbZ1yGMMyrSEa3+k_NnN7X6tS6EsA@mail.gmail.com>

On Fri Apr 17, 2026 at 12:21 PM EDT, Kumar Kartikeya Dwivedi wrote:
> On Fri, 17 Apr 2026 at 17:06, Emil Tsalapatis <emil@etsalapatis.com> wrot=
e:
>>
>> On Sun Apr 12, 2026 at 3:33 PM EDT, Kumar Kartikeya Dwivedi wrote:
>> > On Sun, 12 Apr 2026 at 19:45, Emil Tsalapatis <emil@etsalapatis.com> w=
rote:
>> >>
>> >> The WRITE_ONCE macro is identically defined both in bpf_atomic.h
>> >> and in bpf_arena_common.h. Deduplicate the definitions by moving
>> >> the macro to the commonly used bpf_experimental.h header. Also
>> >> move the READ_ONCE macro to the same file for uniformity.
>> >>
>> >
>> > The right header for these is bpf_atomic.h, not bpf_experimental.h. We
>> > want volatile loads to be shipped with bpf_atomic.h and all other
>> > atomic primitives.
>> > https://lore.kernel.org/bpf/CAP01T754eOs2DCjMmkK=3DCppEwfk5EX84tc70ZqS=
0_OxTfgxE=3Dw@mail.gmail.com
>>
>> bpf_experimental.h is included in bpf_atomic.h, so there's no possible
>> breakage there. A bunch of arena-related code like bpf_arena_list.h
>> also uses WRITE_ONCE but doesn't include bpf_atomic.h, so we'd have to
>> manually add an extra headers for no reason. Even if we do that,
>> bpf_atomic.h includes vmlinux.h and so any header like bpf_arena_list.h
>> I mentioned that requires WRITE_ONCE won't be importable by userspace.
>>
>> Besides, WRITE_ONCE/READ_ONCE are ultimately compiler shorthands even if
>> they are used most heavily in atomics and don't stick out in
>> bpf_experimental.h.
>>
>
> It's a sad situation indeed. It just feels odd not to provide the
> equivalent of relaxed loads in the header encapsulating all atomic
> access primitives.

I agree it's not the best, my first attempt was to move the definitions to
bpf_atomic.h but that ended up being so much extra adjustments that it
felt silly to do just for this macro.

> bpf_experimental.h is a kitchen sink header for everything we need to
> include that doesn't get its own definition somewhere.

Maybe that is the problem? bpf_experimental.h has outgrown its original
purpose, it it worth splitting into multiple headers to avoid carrying
around all the compat scaffolding just to get access to a couple
definitions? For example, cast_kern/cast_user and the hardcoded address
cast bytecode are useless to most programs (and most arena programs
since they require LLVM >=3D 19), but they are still included everywhere.

> I think trying to be consistent and deliberating on having topical
> headers for a library you want to export is a good exercise to have
> right now, while we're at it.

>
> It might be cleaner in the end to just place ifndef around all of the
> macro definitions in bpf_atomic.h. That's probably good hygiene too,
> since I presume the naming is universal and programs themselves may
> have their own versions, etc.
>

> Maybe others have better opinions. I would have suggested namespacing
> everything with arena_, but then they work on non-arena just as well,
> so that doesn't make too much sense.
>
>
>>
>> >
>> >> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> >> Acked-by: Song Liu <song@kernel.org>
>> >> ---
>> >> [...]
>>

