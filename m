Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795475864;
	b=tsk+OBPC/LAeks2Gjo2YH0jO6gDYmQ2iIrqwH5+7DaiIPuWDIOBfEvQOeE5EWtM7vhqT
	 SWNOgKyzPKP9uT9BOmz5pKbHftsAiCOvIBiSKExe9QIbFn/Gr8b6xgzUvr/5YP6dv4pal
	 wUwAWxbVjrgIypJKe/10KHEU/UPzXYwVX6zTHTLs5z+Ep9vXjGgl7E8X45UTeRVaoI7qh
	 6hH+oAfEgAAoWCOEtXGwC1nFJqI8UFyGw58iw1y7Ny7s4zhl62NelPKva3WT6jApTK3IO
	 Zy3rgusCceCIVDtX+PSZJeIYysioMvRGldxydF/HrU5ru2dd1SL2UV5ikizdD/5VfNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+MXRXuLPInN3MQrHXJcGu5dPrrdPX+141SdN1gzh0GU=;
	b=47hQcjYrKHbsSb0PGzLeTV/jIvs1Nw3FLVpurGyzdgJE1BDiKZT5QhQK0yPRDeAQ8VLG
	 ff9JIKBkdouckYhay6fctwY3aqG4Hw8Nt0i66TDM77fOl1f+ufBDXQqVMEYjeVSgGLP1B
	 5EMDSOHZtT4K/2cdgMIB8TvxDGSZCMbpRGQ16H0byRgCV5b8+HOq/6to3Zn5rzkE1CgDm
	 OCXIw+g/sQRqoxXM9xeYrhRCNdp7bZmXbbXNQo/q6uWFx6I4Gxf2hb2nEN16C70okVt42
	 ddBX5y70Bp4ZPMCexITQBs2kDUULdfBmWIQadg2874ywYl95JLbh0TuBvfbqMmomXGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=f2URxq+P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EE0606A322
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 23:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85EE0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=f2URxq+P
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b439e37813so1676871a91.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:17:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795475863; cv=none;
        d=google.com; s=arc-20260327;
        b=IKXEFxpRrtVlbZNXMNWQqyIRDkLNJ005V4S4oXzE/Qpo8s+36FUq2t5ygXMQoTr3Ls
         oaJ7pTHpYPz+qzTi5jNqRZlehf8CXgmWMp5gKAYY3Iz8M1VNqTfHSwbGff+Yrjfzz0wx
         rSjq9YP/0DFXxecFgNhu18bLzcVVozUOZilHoOdJGXBXFT8JmHqpTXNGFlqWaxpUS1nU
         QoVUZHDBHWfVdbev7yVpxmJl9XvcTHZwT41s8aMId/+lDXPY14JYkcVKnI/Wyp/N4NOY
         NU/wlksRtqpQK1ptW/CNaITQFEkMOpePqkhgiphJsTdPw6MkC+uwadlxSIChpLtAuyNt
         ARCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+MXRXuLPInN3MQrHXJcGu5dPrrdPX+141SdN1gzh0GU=;
        fh=Vz7pUW6+qfGcVPNbarIJuYnhB477nSemYNGYP55fGdI=;
        b=Qr4ullpaqeg46F4JaG8LaIh6L3Hr/evNwRFbweNoaTY6AHea1B0z5SelTSnzF7moD1
         NtX5lZgSxURORROS0N3aHey1GvgdeKCywOrrC/rk9IxpCXAZBiwURUGs9t9SU1GX0gk0
         kZ1C83YCUDuMZMHKjilJ/tKEfc60jaCja6zYrInUh+88Ui2ORnelkZal//s8s4yNdOIs
         RwBJiJJbbDzvUG0O60hgxrKuOy+SBauuzn/ElwjEvKsYbosSdNxeVVSCNkpbwRX1HNwm
         rGch0lxWLCToGtNkJwwYuHMhNlETN695uKRLGvxGn8ENQqEDZdSkKqBR4KS2KsGbPIbv
         lgig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795475863; x=1796080663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+MXRXuLPInN3MQrHXJcGu5dPrrdPX+141SdN1gzh0GU=;
        b=f2URxq+PdSANt2DyfE/LnSY1XFoTYnOosj5xEXQkbA7SxI6W4QwU0HmSJshejcTWky
         S0FQGoGeqWv/V4cetnAuhQG9AIsuiihN0orRNBCn6WjeSaid26HA+lT6VUTjWcBQSD62
         qbB1PFXofdfinS7Mln/088yRU9CiCBNNcCiudlFZlzwG2Ibxhw2O3aFEMNMwREoEyrb7
         CsDxG2c54h+p3PHCJY7OlHB3qiqGkyYxICHT/g7CCS/5/T31+MIRFHRPhTmhfz3hmzG1
         Fon7afxI8wozcjBzuTy7rCmabVdtDYIth244kS2420jGicRJ8THCQhWgSfEHI5cYMGye
         12ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475863; x=1796080663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+MXRXuLPInN3MQrHXJcGu5dPrrdPX+141SdN1gzh0GU=;
        b=QUKUHuI7p8oWQaLY//VL9vb3Lhec94Rwk3Oc4vdQo1LvhFxtW+wbKru0ywStm04Wmv
         egbjkn7S+WHzXcHyTkwH9Mk/3Py/jMV1nYpF7yvDxGJcGEV05m+Ylz1o4oqheN+1M7n3
         3ACF6KK6UN7gjWtcD/5z/qVKZRm3FYMVWLDOt3gjiV+79WxoEDYRxswEPnxNhNQf0PPE
         ydho/UTOm7Y1dCPyZniK2tKlJM16M3vrkXxZPu2Qai/jgL0LOFt4aCSt1qfTIQFZWhD3
         0C8NVtNXatEcbm8TnaIJ0XGT7pRBIF64tjKQfOqVnoifO1S9XN4SuCnC/MIKNymRrR4V
         GRiA==
X-Forwarded-Encrypted: i=1; AL+hErHBlggY62wh0NcUayWXftGXhUnPfMw95TOhxPxaujf3e1bOcCAMZg5A6bsrBRRx3wK9XJM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9890gcSsJ4/FspD0WiSmwUPhhsXnIAzqtTxkq8D5q8BoNM3bLc
	juX0AonhdhBTcFVIXo4yI5/Bqign6tycXmg0dI6yTuwTTNXltfmhmkyHMrziWCgw178Yk25JeAs
	dQrJFlcCmVP+VzWq4m95z457OHz168Qnhx4C2uE9M
X-Gm-Gg: AZFdTZdRdF3+OTw5vUcha9J8XpCWixC19LOdF/f69QVLOcga6F9EaBU7uT89yMmfH2R
	CoVDHWKGb9JKGI1bqe8QX41wDCIe25qPZIykrU4Yq/3tvt5iz/j4Bxt2FjTh5J3WSAsVDkrVEOA
	kJZgdN/2SGRuVARG6QUE82saEQafOGTx9qhJE5GWwGm272Tbf4Fflahw0Dvy18xZkHrdJ1EEDwx
	81CogEH002FPanYnfWi9csfTBkOrfHZlRYtiOoItCYhlrUZxqJ1TH/JQHXQ66aT54NN1/DMUJh4
	HztVOIAVWyThJarvdLzaeS2BPaYxnM+d18TyXoAs12g+n0W3qVoLVXYmQrMEM2IKkHMG5S6mewQ
	T6o5BwRQamuIY7UjHoMlMH6wTO0ewPFYkhz8HQWiMZ6OJN0FCHsG0DFiywkCaOhdKbKNs4Q==
X-Received: by 2002:a17:90b:380f:b0:3ad:1da4:2ddf with SMTP id
 98e67ed59e1d1-3b41cb0cae0mr10882903a91.51.1795475862780; Mon, 23 Nov 2026
 15:17:42 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-security-namespace_free-v2-1-65591dbba7b3@kernel.org>
 <20a5e5372530caa583c57003dfcd009d@paul-moore.com>
In-Reply-To: <20a5e5372530caa583c57003dfcd009d@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Nov 2026 18:17:31 -0500
X-Gm-Features: Aa3M54o74z8pn5Pvit6S16im7-Wxu2Y0a6J5-TPpee1sYBnPKi6ZczEefWRjtvE
Message-ID: <CAHC9VhT78Ktssi1gLWTKPC6KEgg9npeTf+2-vjwANeAbPoSC5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] lsm: always call the namespace_free hook
To: Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 6:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Oct 29, 2026 sashiko-bot@kernel.org wrote:
> >
> > security_namespace_free() returns early if ns->ns_security is NULL and
> > skips the namespace_free hook. But ns->ns_security is only allocated if
> > an LSM requests a namespace blob via lbs_ns and currently no LSM does.
> > So the namespace_free hook is never called at all.
> >
> > Landlock only uses namespace_init and namespace_install so it doesn't
> > care. But the bpf LSM attaches to every hook and a program attached to
> > namespace_free never runs. We want to use it in systemd-nsresourced to
> > get notified when a user namespace goes away. Right now it has to kprob=
e
> > retire_userns_sysctls() for that.
> >
> > Note that a bpf program can't work around this. The size of the
> > namespace blob is fixed at boot and the bpf LSM doesn't request one.
> > And security_namespace_init() allocates the blob before the
> > namespace_init hooks are called anyway.
> >
> > The check isn't needed. __ns_common_free() is only ever called after
> > __ns_common_init() succeeded and security_namespace_init() only calls
> > security_namespace_free() after the blob has been allocated. So if an
> > LSM requests a namespace blob it is always there when the hook runs.
> > Call the hook unconditionally like security_sb_free(),
> > security_file_free() and security_bpf_map_free() do.
> >
> > The bpf LSM attaches programs to its bpf_lsm_*() stubs so fentry on the
> > stubs shows what a bpf LSM program sees. Booted with lsm.debug, which
> > prints "LSM: blob(ns) size 0", and created 100 user and uts namespaces:
> >
> >   bpftrace -e 'fentry:bpf_lsm_namespace_init { @init =3D count(); }
> >                fentry:bpf_lsm_namespace_free { @free =3D count(); }' &
> >   for i in $(seq 100); do unshare -Uu true; done
> >
> >   before: @init: 200 @free: 0
> >   after:  @init: 200 @free: 200
> >
> > Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > Cc: stable@kernel.org # mainline only
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  security/security.c | 3 ---
> >  1 file changed, 3 deletions(-)
>
> I just merged this into the lsm/topic-7.5-02-lsm_ns_free_change branch
> with a corrected subject line (namespace_free is the callback to
> security_namespace_free()) and the stable tag removed; both changes are
> annotated in the metadata section.  I'll be pushing that branch up to
> kernel.org shortly.

[Side note: my apologies, my script got confused by the sashiko review
and only replied to sashiko and the LSM list; adding back the original
To/CC list]

--=20
paul-moore.com
