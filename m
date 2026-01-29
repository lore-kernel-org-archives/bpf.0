Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5A52FC890
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 00:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769648352; cv=pass; b=hQbUCLDsuMCBuLNRRKyuDs3UGxRVBDGuReYa2d/+XWlXDOKtqGrUHJ5myPe3bJJeMgdrmgg2WXJjscTo6wdNxkml0cDNcF3V+F+k3lQmEkuXvHnvOwDZgklqM4XfmBE+qwXBzGZ+7UVr1jNmsUbdKw90YSyfS0O1tjbJFKy71hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769648352; c=relaxed/simple;
	bh=+L+EqsxFGbq9nKKnaprPm9Ir3tOy0vr3+xqa2zLh1T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gi0/QvzcPDJxyoO7qcyEMmqTC3AfGE37qsQmYQ5Z8xC/rp1gFoeb9IKOH/KLa3H2u0tuugMUVddRKss8SZuqJ+P3r0IyjV6eHuuK2L2Vq0dJp0DHhw4qkTybff2nRb9bOT+4qRZ0UZwkHmRBb2Q8X4H3m2QcpyJnzXt0MvuTFdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgiTQEnp; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgiTQEnp"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b872f1c31f1so62394766b.0
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 16:59:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769648348; cv=none;
        d=google.com; s=arc-20240605;
        b=N2B6otuMSsmNNxRldZz2XihMvXqRvmtL2yUsq7NmZmXb9GZsfPMuBeg+zDGXv1eiEI
         8HRuVVjiTHVFETIOSZlWS7GMTHZpcbeQLaqr1HUyEut4CsrbsyejHRyYMWc7GM29i6Cm
         CCM7KfYJmkJH5DWbnQoe7UGWchzoS/9aF33DGoP5WI2YiFanA3at+iLrthQKv56BadRB
         caiK6o8AamPE4d0SEK+on2luJYSpy6HykhphiTN3I575ewwYXf1/g0gLVpwx97uWm/VZ
         5Nbat4RulKfkVgxG1IXAaEN3sSSh5NTvILob4isuNTFKuyW3zViEgCqat+JaQGxVReTB
         aqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
        fh=t1OVqlnPfHurr2PR1Fqva27vE8z5ERHK229RCyWzi/E=;
        b=RRAAGt4M6IqMUYo38gCDwW9eacRGd4nYbxrl4MaUh2TEYjYjAxoJqir1WPoxXI30yr
         y0gXK0o2oJvco5jm3xCIcgTPW3+G1Zx+p7quTMPmgpaceNPgBpRO/Igi4MOUtYtmb3dl
         G7wyCCfx0as+ds1Oqb9+v/BGERKY7fDaUPJjiBQU5f+Pn1UAsywwSjvlwtvlXoGboD6v
         3eQ4d98RPFKuvhaW7J7SPoJb3KA2/qau2ck4Ux/0qhVnLzuWWayHMCrm1T7mVPB6Vf+x
         tNfSKmK25rUGQLYMDZjAUqnCgH+SjHqUN3EpP9IjCOhvhrK/G/pkCevvUq9UN3CP7Fpw
         ht7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769648348; x=1770253148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
        b=kgiTQEnpKJp/pjWzH8UIBoZE2prYNeOdPAmDcSgp2w5aKDPBJN5uF6sIQ17O5EEcaN
         ACyLVBvVNlwDDlteA0YIqufuqAY74ZjqMbYJ4tJU9NEEZn94CcJXo/9Epjd/HQczmXSw
         oQ68UlJ+ysPe1pwWStyhBRWb1KgBhwrl8ect/5mMeMeC2LbIGU2krUo3qleFHZZcB5UL
         oZIcbiABabn8ZJ0AByRhAkYpLWueJfg6OQRWhq9Hw7bnfLKCMVArAe1ksTnsKICVRJSs
         d5Dacf8qFkgg7Xd+y+e6WdzSOZLhxyO4qtDTDvpFsyFA0L760P9y01OOVPtjLx3ifnCU
         1Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769648348; x=1770253148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
        b=k8QJDImz49OSWkK8js0sDIDH4S2ajEGgFQJsQKmX6CPBlDUxv8IxCFJs0lFV4CIkQe
         RJC3A0djhoaTFrPSGVBj3xdaSr2JKcyCdntlVjGiYcsTzaKyWr+sWi5+PdH/o4tUjvGM
         lNY39jnxXtafiDgyCXxQawSSXnqZkp3PevWZF8sXa66HjqUZX3V+xN5hnCD6JAAqE+Zp
         HUmEHp5f1EnGZQ4RKcoiPB7uc5Fyd+P0XCi3mzbCnbMEdK9lmqMSeSL27G8f78UJkftf
         3D35l57k4LD7CtpQo90RjHSYxGi9mzk9m3APmwon3iR+JtLG6o6VoInrevp9HQom1WTf
         CRrA==
X-Forwarded-Encrypted: i=1; AJvYcCXB6Yu945EpDIQvjBsATDIVCjaq86YSWO2LusvdJnuzRQaeZ+u0jGY2SylbmVUZDgo3QA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydJo4iJSPbkEIskZfpXoRtmDPZ/OF+rGJcmO5TCG4s0eX5DHt1
	5LRsXCMkrTfpvcHOmzTXBmVghrI81qPqR47x9F8MLwgDiCC/+rgPbJWGa65axfATExidp69AJ0F
	631iP1xBvTv6XgvlOzi3wxAotlAdeZ2Q/5tVTXMwE
X-Gm-Gg: AZuq6aIJxIR7fF2u0rc0kpuc5TS/5XmO3Knih4wridj+A6BjfzpHJX7Hp6drIe7umDB
	dwizkhopFnQWK0I+Gg4zm9mnQuRbPVvB0gh0/wDlkyKt1f99IysgA+ULfBybg+hK6bCkUXIts4Y
	kM71lCEIqQsLUAqR+9CSBThnPKKy1PzZt9maun6xruvdd4oq0YDFxeg5Qs59UyRp3SVdNzzBJDT
	3HLKM4O9gCtH0HbtzQBpahjBKe5Z1j8xdTXPT9I+0KMnnZRRef/R/3YGUrzi6Thy/n15Fr41CrE
	Q/ixEb4ObVyvr3aFgP/Gr8A7uHEMtw==
X-Received: by 2002:a17:906:f585:b0:b87:d722:f824 with SMTP id
 a640c23a62f3a-b8dab3cf66amr455166566b.63.1769648348337; Wed, 28 Jan 2026
 16:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV>
In-Reply-To: <20260128045954.GS3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 28 Jan 2026 16:58:57 -0800
X-Gm-Features: AZwV_Qg5mDXEWLmzjtDFHSng8MB2HQLUBKHQ6Wr860X_lRTmL3Z_ZmvOjLnN07o
Message-ID: <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 8:58=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:

> Very interesting...  Does 1544775687f0 (parent of e5bf5ee26663)
> demonstrate that behaviour?

Reverting only 1544775687f0 (functionfs: need to cancel ->reset_work
in ->kill_sb()) does not fix the issue. With 6.19-rc7 as baseline, the
simplest working recipe at the moment is with 6ca67378d0e7,
c7747fafaba0, and e5bf5ee26663 reverted.
