Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795830680;
	b=MeYvhTHxKZ4iXhTyh26WWr6zuCkNIqJn1mjR1Pm0pNPIA+w4yQjR9XjhYWIKPmBxtM0W
	 JFOLLebNv8C3wNxlEue1Tq3ORBfC50xdsoOnUkEN8OZQwkUZIYjC9KvTKQhFHkB+ge9r1
	 DlDvaLi38Sx1MVq9sNaIOiTkmL0E9n71B8WCnmN88TeF4nFTnKGIe93HvoyeB9PCPqsxN
	 TTy6ARqcNkpWkZ2XdXv1lsZCtP2RoAYLJAazJFMpAEcpMYDdzNPZsH1cg9dDihy837zBg
	 8HLQlVYHKPpf0+DgqJTm7KD4pvug4EcaiFngh/+HOuKbZjmv/5xv38kvB28OJb5DD4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795830680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
	b=haKWMrB3bQjHQ1L08cunW5NJ+5OoUCIjxJfDK5rInX6nL/yMJRdNPLKzRUfzFk6KVogR
	 1wTqS9Amaw5nYZZ1FdjRmpEJYHOKyYpfgi71LeAh9qedqnYvij4/hGGHhbAAcyo5XRHHw
	 I0p8kYckSDQb6vpsuk25zVPWby4fUONc99uIgczLuDM0QVb3Zfhb9exlSzHxPMMhCsIhY
	 DBwfBSWEys353AnOj1heR+UmO/Y3TqE5uKwGW/Pb72w8XG5otTj3dcOR1ooCNgbM/SXo4
	 Q4hzVG+0HOeQeXGTii1ljUAfTZ1K8BqrlQOqfrFm57y8ClptrODIQJsXb81iNWZ0c4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XLosXPN4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB17606A327
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 01:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FB17606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XLosXPN4
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so1388182966b.2
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 17:51:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795830679; cv=none;
        d=google.com; s=arc-20260327;
        b=XOl8GW7ToriWAt2eRtctWdjqqIE4cwTrYlcyMYizktMm0lqrJq06mr2B+PXDrMgbtC
         PHVEvlrdUXSsfqQORsOxnjzom5uGKeoOKTwZTcC8ynCG3NnpUMGGuVnGkXDJZUaWUgx3
         UUZw+J8fnV5nYjkHz44pFWfh0x6QHaVIHTfx1q823LwtMXNi0DApU4mBUjy9ie78shoX
         Y/TqfN7YSVB8MgS6m3y2qlVAqJCdADh+oT6OLQqkzS3zC+PSEbViBuMyWfIE4kEgJmEl
         fSqIO5aNhu5aGKvdddlmoByKx10Szj+rUvh2UKP7iR1rmB85uDDpRkm5EMDkQilSo+YT
         ub6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
        fh=cAu7TH7zeVyqNDclAHg9cxokpBucPDX68YAKsmnBVTY=;
        b=VuOEVvnCJBxJhQBgqmk2VrRXMs2vGr8jmpeR6C6dNjpAL0KGCipzPM8fTwXUjGeq0a
         GFcD7zqePKFRo/8uYgyQYjYtVVtxDcZEfMWY5hPkndwjQvd0+LaOV/dUxOUGj6oevvYN
         atCZDO0b62fB2jF9VaAcPcP8gGpvpSyxpwBvGU+lyzj+fp7Fv1CM7rzbEK8/AD7rQ3zO
         W/x+GQdVyY/OWDoClSWLXyI0Mz4q+mu/88AMuYB5BrFjclr4OdjhzG42UYb5I35AQp4C
         BIQr9TkW1GYMyOt2VkHzzCdVnthuuJuJy5fV/R5opSWMW5v2xG0x7Jt+GaiUcE33UYan
         pkZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795830679; x=1796435479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
        b=XLosXPN4XY1X7SNdxkqBL+OmW6RyoS3KUKiJGN6VkhP3L0yhHIWAe9gfCGB7c23JLd
         lHNLLgTgGaPV+ANwny7auVJWhylTPy7tn8Qbd1QmlxO7gDNExEWgSGEhy30NAozJQ+8+
         +xKv07hbVc2PMmC0nQwONM+Snu/fB4CVx2Zu1RVG2ABrNV3bydSS40OT+TsJEZK+JELi
         MFuPTs18dGi6k3X7RKL9C6rS6PY4lyASR9cQGoX1ApSJvF/sCt8fWc54v5qN8Mgd+424
         mRGAbRe9QyqlYYy8UZHrD36MAiba/qdVjAz2hG+uSVag6rBQPtZrBpUV+D6X33j1iq7k
         51pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795830679; x=1796435479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
        b=TFJ09Hyi6/YdaxKc1KlyB2FFC8F6ohpWeknl/hM0BJpIG8MFEHm3uPjDCg0DLmtX9D
         M6smj8/NN/vywiJP4+SYpXAEXNTJSXtq6zlMJUKbaEJMjYm/Q4t0MN37xjg3DkcMOSMx
         cefLOODY6btD8Pi0W9IUNnpvKGB9k8xwJTlHMTSoiAvlu/ZGa0RthRcT1nAYWqKXz4dw
         ZL2Xx3xnXoIrE5Ta4USLKpHvAWMzNfeM58MfOuCMxYgkh7Dg3V/FHC13qy5KXjXb8raq
         +/6uNO/2j1wKb2sWhWlSL0xLwOJ3Fi8mseDhd8HseD7H03YpdNU8HYu959NrxYmpB447
         ab/A==
X-Forwarded-Encrypted: i=1; AL+hErGFjX172kFc0pvpLQMViC9Np697TBSOALBagxVAIUxknISIavTBpBppPgXNRtH2eHLI6EY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oXVseJLCy7op4rVQeDKk8S1ExvCJwu4WSibL1cigRY3KHSP8j
	LmZw5d/hsbDO9Pf+S+MTMrManOp2MTI9Xls3OXV4Bya8LW58OdtSoOT/0x0iGeeBfxKmur0Dvr8
	k7qrU55efmfQdeKaGKWM3iF0BoEArfC4=
X-Gm-Gg: AZFdTZfpyDZcam8B18GDX3nfmN9NwIUFmEWwENGBJ1i1Tx3kfQjgJj9s6s2U2Gqx5Ut
	n0unrJ/m1rRiI+k3vpmUGyzsF6IuRu84osommtq4cZ8wiSYzIgFJgL1sVBCKA9Q6n8o0neY/Fql
	ncoNlvUfm3rUfUZ62XomWxVCV5VHx7x4f0wLStOl5AJZkl1O0k9kUv8nvw+WIBQ48ZwLO7B2tp1
	apWC7+GB4J7+H7uM0mffuKtccYiSw+J32gUTD6QtSBeiK1Km9yEmt4ri1h4+Sn73OjSpITve+2W
	uRIaM1Ftnit/b3qhncg/TOALxcrKlnVN1Ok3odn8ZabhDWL8YjpaoOqHy0uRGhk4vfWebQOGJmd
	cHc8e9GrAnGZ3EXVYUBbYmFeP3wvjqsrjNp89
X-Received: by 2002:a17:906:fa82:b0:c50:4b6e:329 with SMTP id
 a640c23a62f3a-c513a5eaea2mr1724212966b.15.1795830678877; Fri, 27 Nov 2026
 17:51:18 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <awOQDOel_72Xwjm7@kernel.org> <20261127214103.542291-1-safinaskar@gmail.com>
 <awn-ioAuksHNV-Rc@kernel.org> <awn_Y7oI4ckfsjSv@kernel.org>
 <awoHex4LVst2JwkO@kernel.org> <awoO9R7YF_5_6dHA@kernel.org>
In-Reply-To: <awoO9R7YF_5_6dHA@kernel.org>
From: Askar Safin <safinaskar@gmail.com>
Date: Sat, 28 Nov 2026 04:50:42 +0300
X-Gm-Features: Aa3M54pCi2p8qLdocdLXd3OCMkn8g_j_UUSVEEax8LAEOxwj1oFmxFAoHI8_4lc
Message-ID: <CAPnZJGBnFyrmr88OsYkMwtLiR93z4g0NAuoMurcnhcYFXz51jg@mail.gmail.com>
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: aleksa@amutable.com, alex@amutable.com, alexei.starovoitov@gmail.com, 
	arnd@arndb.de, bpf@vger.kernel.org, brauner@kernel.org, 
	containers@lists.linux.dev, corbet@lwn.net, dhowells@redhat.com, 
	ebiggers@kernel.org, giuseppe@scrivano.org, hughd@google.com, jack@suse.cz, 
	jlayton@kernel.org, josef@toxicpanda.com, kees@kernel.org, kpsingh@kernel.org, 
	lennart@poettering.net, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	luto@amacapital.net, neal@gompa.dev, oleg@redhat.com, paul@paul-moore.com, 
	ptikhomirov@virtuozzo.com, sergeh@kernel.org, skhan@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, zygmunt.krynicki@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 28, 2026 at 2:15=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> thinking more sequencing than data structures. I.e. I have a game where
> I need to end up to process creation without embryonic state, and add
> just enough weight to kernel to support that outcome, and that leads
> to ~2K'ish LOC of extra kernel complexity.

So you don't have embryonic state? I don't like this.

Let's assume the following situation. Userland's PID 1 is already running.
Our container manager attempts to spawn yet another process into userland.
As well as I understand, it should do clone3 with CLONE_INTO_USERLAND,
and then execve.
This creates time hole when there is process, which already runs inside
userland (i. e. its PID namespace and other namespaces), but runs
container manager's binary and have container manager's mm.
This invites for bugs. Other processes, which already run inside userland,
may somehow take advantage of this.
For example, see section "CVE-2019-5736 Is a Very Very Very Bad
Privilege Escalation to Host Root"
of https://brauner.io/2019/02/12/privileged-containers.html .
So, here I like embryos.

--=20
Askar Safin
