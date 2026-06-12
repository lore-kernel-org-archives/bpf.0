Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF72835CBC3
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280272; cv=none; b=KbyJkCKfZWK08vy7KaWSu133ZSp9QXEE46b0B/IMMaxTxnO/YBJQnQjyauZpgm4GJrYdFgBU+EKze5hdOGNrPOheURm0hzX4/719Zyio/EdbsZiyO2hOYb0Wyp9bXNf/h8hERMWWXOTtI5llfGLkz4TUMG9wqHdCRVzSC0Go/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280272; c=relaxed/simple;
	bh=Dgq0d5IxI7LC/ibes1FpOx3wjjhpIMfmAGq0LmAr+jg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XNn+nr1wLhL9tEiNv/S3H025VbH9xQcyBjDnDsegt+nKNf2t77inyuzfUnzKny8n91ye6Vvvq6/jVx34PEP5u4cWSmZD4LjpjjHue8eeVbUukr0ep0rseezmfMTxzjnafWTzZPrEKw0D4i2G+gq2OihSaBNi05lypmySxlZfmgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dl65yJzC; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl65yJzC"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43bf95c3f6fso1116914fac.0
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 09:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781280270; x=1781885070; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKS75dTi+dzJ2YpMpG0rfsRbp0U/xYE/c1D9hfWBrtc=;
        b=Dl65yJzC0DEoWyY3j89sUyrQvTQhDSJoRkI4FXftciWJTxXTh0UFCpl6OnaeXtBH1w
         09gd5eeFNZmEpkDCVNmxNC254gLP7/hUdwtpaDAJuWTzoXkVL8edaPuq2pZcv/GG/HEg
         dMc8qSBbIjwh5zsURJpIKNHaieFzpjNMhQngaSajiMvhEmkTfQQlMmqWPkBjHYd6rr4W
         9UyG+3x0Y6dGMFtwTbLdrKTUY7IHpwG7WSIvaIuzmGBHQF5MnK0Ds2BMsSRPAffrRmQv
         rp1vGOlRc7+sJnqmFcZz1btZPGxetXl8wSPYyqzcfzX4VjEH7CX3roSd++NJHwah0xg+
         WiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781280270; x=1781885070;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKS75dTi+dzJ2YpMpG0rfsRbp0U/xYE/c1D9hfWBrtc=;
        b=jCx1JgPPxjmeaKptNGyQToGxl/FzOAVt0xEtivSaUkrbfa3FFEIRMcnhUOq+s6FTdJ
         swJuFfkx/Ge9ly3VQQvhimaxsNzgYa2S8aORGLeO8H7vEXOnOdXqbLFs4B0XqEFQUTbq
         MIXD4SLiR4c/aJ65OEn2WjqW3G++5G9fCIB6+rVfQlDh9vu4McJRIOOZuYWoSZyn4Ecs
         QpKkMZK3eXfnyd/9vGkhbzW1jQ8u1Uy95pntxIgYAMFO8YSx22WRG4fUzi89NKcNdT2h
         zUoTiC8sTp2oru9BmfyukBeMdWIm+z2JXhbXyzmnN+9npagMqBwxZkMdV7Pu9HZ53n6y
         nWUA==
X-Gm-Message-State: AOJu0YwB+WdNqQOH38pAU1+edo7P96KCQD8hShoTBfwYeNfVQ5VzVTuh
	qCg4Zwc8o0QfZhrgYBFQCde7cyoHeNvv5fNuO2zJY5TOp6E/9boubHdOHpbe7g==
X-Gm-Gg: Acq92OEZEADodbL1D0ue5T3o01RMGyx8IiK5ig4Kyy1FXaIvqtOk9qD1NfhFg6OWSYQ
	LlQ1NnRG372yUNyavBSCO7mpOdN/135Ul0oUM4O52+ZU0WcIiJi49br7ap/X+qdr3+9C7hzRLq6
	BuwBjLEKK7iTyyEH7oMN4FHRNa8M4MJNTTkMQd/GDNQUUrHufqqqmhSTU8NY0an+hJfiZYcytOE
	2BukPBZ3gX+qjMUBH5ttUQZTMi9fzDERpoh5X2n/ss6gN44pNVppq8wN2en1qjGYhGwFuM43G2v
	Sm2WgV78963P3sgLZj5Mpde5QY9jIZWvoK/yVrWzYSWWk4REFd2nvkUHMe+i6EH+GqjJvsb2QRS
	L1vLYWzKF+1ibIk81SPu+v7C33NK1okhxzNELVrdg99++7xPSw5LRHhSxmDpFAHjdsaOZyvhZKo
	a4Uids5Qvio5ar7kCz982JisDo6U8Ka5l2lLUIYRGLmIajy0cSUgjDQJuuo+2g+5piqP88Xfz9/
	eRu6LaAvXf1vG6K2A==
X-Received: by 2002:a05:6870:7124:b0:433:cb0d:7702 with SMTP id 586e51a60fabf-4426ee46ademr1365648fac.13.1781280269446;
        Fri, 12 Jun 2026 09:04:29 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4d::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4426abf260dsm2047439fac.6.2026.06.12.09.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 09:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 09:04:28 -0700
Message-Id: <DJ775MFSG561.2SI6FNLLV8NG5@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH v1 bpf-next/net 5/5] selftest: bpf: Add test for
 hwtstamp proxy.
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>,
 <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc
References: <20260612001803.23341-6-kuniyu@google.com>
 <20260612003138.E67A01F00A3A@smtp.kernel.org>
 <CAAVpQUCRU1ie22PbegWgGnfyWw9V0wSTjgQpw=5Wwb2RZ=su+w@mail.gmail.com>
In-Reply-To: <CAAVpQUCRU1ie22PbegWgGnfyWw9V0wSTjgQpw=5Wwb2RZ=su+w@mail.gmail.com>

On Thu Jun 11, 2026 at 11:03 PM PDT, Kuniyuki Iwashima wrote:
> On Thu, Jun 11, 2026 at 5:31=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>>
>> Thank you for your contribution! Sashiko AI review found 5 potential iss=
ue(s) to consider:
>> - [High] Comparing a potentially negative return value to `sizeof()` cau=
ses failure handling to be skipped, erroneously dropping packets.
>> - [Medium] Incorrect struct cast for SO_TIMESTAMPING_NEW cmsg data cause=
s test failures on 32-bit systems.
>> - [Medium] Typo in the test assertion prevents verification of TX timest=
amp keys.
>> - [Low] Multi-line comments violate the BPF subsystem comment style.
>> - [Low] The `buf_cmsg` array is not fully initialized before being passe=
d to `sendmsg()`, passing uninitialized stack data to the kernel.
>> --
>>
>> commit e747f30190af013f6f5cc858f0dacb86e902e2d2
>> Author: Kuniyuki Iwashima <kuniyu@google.com>
>>
>> selftest: bpf: Add test for hwtstamp proxy.
>>
>> This selftest simulates the hardware timestamp proxy scenario using two
>> UDP sockets, simulating a userspace proxy via a GENEVE device.
>>
>> > diff --git a/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c b=
/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
>> > new file mode 100644
>> > index 0000000000000..d0f90f22bea22
>> > --- /dev/null
>> > +++ b/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
>> [ ... ]
>> > +char *ipv4_commands[] =3D {
>> > +     "ip link set dev lo up",
>> > +     "ip link add geneve0 type geneve local " APP_SRC_IPV4 " external=
",
>> > +     "ip addr add " APP_SRC_IPV4 "/24 dev geneve0",
>> > +     "ip link set dev geneve0 address aa:bb:cc:dd:ee:ff",
>> > +     "ip link set dev geneve0 up",
>> > +     "ip route add " APP_DST_IPV4 "/32 dev geneve0",
>> > +     /* We do not forward ARP to the wire in this test,
>> > +      * so a static neighbour entry is needed for APP_DST_IPV4.
>> > +      */
>>
>> [Severity: Low]
>> Does this multi-line comment format violate the BPF subsystem comment st=
yle?
>> It seems the subsystem guidelines prefer the opening /* on its own line =
for
>> multi-line comments.
>
> Gray zone, this is rather net one :)

bot is correct on this one :) BPF prefers normal kernel coding style.
