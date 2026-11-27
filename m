Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795746674;
	b=cceUlO4CQhGE6mmR5uwS7jfA7MAmLDZ4jioGnyYoPD205oXE4qqCb0p9FB16KQfdzUIb
	 FIzm3zXYri3PVpkdkIZ7FkooJq6oaVdmDElFVWzHVGD1bMGQM/GwNLh6ZsXbTX/JOd21n
	 W1R295EsZStoj1uVYRqbp7/TrJULF/98w5SJYhgLCek7fHxeToG1XymEya/AQdEEXLllK
	 81xDuZTfkz8bifgdRp26ofFmNV0mUhP8NAWEiitP2WnPpfyfk9Ur4i6h6UyFAXDIKuK1s
	 tEV8QJubDWVd7TLHIpCDDFQMz1/5oWImw0YArOD9UHi/defdpFqHMqthYb46wboOcJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795746674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3mvD5SHJizr8aoJUr14kNfOc0+9+6jccMe+xxh5ocXI=;
	b=gANvg4jW/Tv0QgTdjCFrXnp5zcKwg+lw0HL8RhYtA7wzdcI3P+6blpHUlcpXseXIIBTR
	 JfPS+GfUIZ4ULxL31uzQTwUCqKS5+Im1c5Mqjz9tSzh3V7gNOWfWakfHHbICJhPR1ET70
	 n7G2+qe5aGVymETHkp7PIYnuTJe5/Rf+tkPG6xOIDdm6fk+3/0KSj+SJUc9M2iCkr3JNU
	 fckNQg75fe7HqhMdoyF1ZyRFkhEi4jwHvloHaeFOcC+ITyknxQhqgJ7mfHwGqBM3PtrB4
	 NYC/69irfcLqmZ39pkboqmpfz+2Z8/A7gKc7VhHdx73TbcFxJoEjLVQvvnwwWxXICxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qERfAWsJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F9606A31C
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 02:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B4F9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qERfAWsJ
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c335ff461aso419843e87.0
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 18:31:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795746672; cv=none;
        d=google.com; s=arc-20260327;
        b=LMjaeInrx0n/BbkF/AR5O1Tk2F3qPK19+YFFSOlU6ADfKH4LGQqguiIXTB23mjXSdY
         dvQdMWZjPjQtE1wQ8kcFO184DCv8/90+4qKqqWi0jpAWgutCrnfA9s8ece2CiVpLPl+w
         C6xyGcqi5ooaQpIWD2Vkwrg4hyZYakcncTnD/4jjEzeUV+gOnKxV2zvAFFjfgq1GS8eJ
         aPfqfGEy1n00B3NeI/azoPVxKIO4k1GcFn0xeYRyY04Cz7NSw771XP0tUW5wUYML0hyf
         Rp+OXl1LkGufSLwnU+xvjIzxjDbq/HzAv1SOiNuoIXccS+EyZbEe3cEKU6MiwNcnIiFu
         pPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3mvD5SHJizr8aoJUr14kNfOc0+9+6jccMe+xxh5ocXI=;
        fh=DLQPJNJJ6PHy3/4OfNJr2a/CdJSzJkVEmmkwgcTGMFQ=;
        b=iHtq3jhb/muAVLOu8QJGPvqnPOEcy6ufH2YK5Fx9jACrRLUBZU48Oc+2hukjJlAb9C
         sUM6BCMR81cREyl9SA/5X6U0uXiz52ffVSvDbaIhfkYBxtwdffDEhVkxCWrS2QbrQYEP
         vDBMawxOCPm9B9QsuLvlHt6I3A7SNgZvWX6w4oChjKYN9kA6SoemBX0Hq5OLqLYsTUSg
         hJhiIHWkL3g0UoSSEbivYiHI6cFHbF6ddG5B4LfpLCKvWTg+jgqPQAYQzbB6u+LYteRQ
         xeX8CvhVXCcjuzb5GAoZdLpuf0uSBDQ9YpXRZcHyX7k7mbbmjLQH8fEAOEtAzdvQ7NQG
         IBBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795746672; x=1796351472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3mvD5SHJizr8aoJUr14kNfOc0+9+6jccMe+xxh5ocXI=;
        b=qERfAWsJLcMKn5W1+KMjLc9CebAaBdsi/1G+woZOLgB3/twU0XYdloPUN2mWvrM0lq
         ZmjkPHBg6hE4TECOpPUuME67pi/+kIWTh6dKsrrg2kwClDgMCrryU3PA+g2T90pkxul4
         hulvBnFR65xIfs8Qyt50nkDQB4iBRRfQSVDpJfveyavzGjbuZdHPI/Q5Gx3Pv4qg64pr
         twJ8niXamQL5zeCiMh0Z0HwTWL19o5A2ey9bCjlwLKyqIEXD0+mzNGfUAQ86estOQGE5
         wuoacrdvsCesOjmpc4qxx5bixMVTpnUKCsyNl9aIRxasZxnefL3rulkYEJIQHET95FOZ
         8oNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795746672; x=1796351472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mvD5SHJizr8aoJUr14kNfOc0+9+6jccMe+xxh5ocXI=;
        b=B8UAyxLoBmK8uBvIDwRQJslheiHFhegs/y9WISwHMXhu0aea0uKTvb+pUh3SRkEhmo
         AhPMxm8RwwYrzIYSzEBRw4woODVwiIgcvPBd8OYh0SupU1gBVN0k/OODa43PulYpIGwy
         m7zyMzosFuip1oQqr3BrJoAG0c732tzmEGWnKhDDsu6lw37qrBIhGaUN75p1vR1QHFy+
         7GpK7fcTEboUXbi8PTn3MnQ41PBk/FR42JcIfQX+PPd5/gVO1z/Pc+A+Wpczom94Hon+
         nqIsrqZgDZnYqfDkCuH+if+cOk5K2dg1NjbyOpKZcqNMAsJqIskicDpvaQT+C8B3e2ai
         91lA==
X-Forwarded-Encrypted: i=1; AL+hErHba7GFHa2LRXEDcUlscAQWiB0G+gikeycPZDKnMlNzZufJ0On1VYzTHIUBlJMxGyyqWOg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aHCR/lOHApObuQhXL8bXg+bc3EUPDSxZ1zyVtj/4T2RPkNfj/
	hI69eh194KjarMaFDecCTTnt4HHo6c7Vq32UfBbN/wtSs7TG/4tUYTcYVYtnvK10hayWrgw+oQY
	ta72SPSCqizNJ4o2XZ6Ei2fIYoZWkouo=
X-Gm-Gg: AZFdTZf2I1e5TCRSWKUfyhAREHxqKqTkERmDxjdJL4HLtsMCi8Wf+oaLVwAlTpCenaw
	YK5s94MsXbbaLBhCwtju+UGWJmx/2s8iKEywS2vUfeNCNRx02a2AjsB10033lwcEaWpWe19stTd
	Gr0qceyMG/cK0T2VGyMNXowGhxFfsXqEn2P57g8tykOdYgWVAHCYfgDCoKF2gSfK3zDWRfprc7Q
	IlVBmUylgn1OlWwMtTtm+fJspy8tFcaBjcY/EuFNdp5qM5L4jemEFiBGrK1wkDImjQmq4UY3ZBZ
	e/2OuNYqWl+6cQS3xw7XxTB43Ip0mJWef+Wi8Nj7b5JLsmgR5l97ft0okLZpM4t5aUjh63oGgcD
	Pw87TOZ+SUbFHNaJwABNC8c0PE4pIF2aeoC6ruKbgOU3ibLwMb2Tnh3xIjlI9kFE0MqJF8B3uep
	Cfs0/Jb6RNYnlDZvQ98FVLRg585+BZsU9nO7SR7d5s18kbRYN8aow=
X-Received: by 2002:a05:6512:b9d:b0:5c1:4f5e:4b59 with SMTP id
 2adb3069b0e04-5c1bc844972mr7043793e87.58.1795746672038; Thu, 26 Nov 2026
 18:31:12 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179562059260.3381969.13546710565371160648@gmail.com>
In-Reply-To: <179562059260.3381969.13546710565371160648@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 27 Nov 2026 10:30:33 +0800
X-Gm-Features: Aa3M54qQCzHWtPap6VwRTDk3zW_mgnH0uTaijvFXX22zIZb75qUgadyaUbnQ8mk
Message-ID: <CAL+tcoBzM3owy4tnRWW_ZV+0Tq0R=_GnrigL2Ud=2DhyviUivw@mail.gmail.com>
Subject: Re: [PATCH net v3] xsk: keep the charged page count when pinning a
 umem fails
To: Kyuwon Cho <kyuwoncho18@gmail.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 10:08=E2=80=AFAM Kyuwon Cho <kyuwoncho18@gmail.com>=
 wrote:
>
> xdp_umem_reg() charges umem->npgs pages to the user's locked_vm before
> it pins the umem. When pin_user_pages() pins fewer pages than asked,
> xdp_umem_pin_pages() overwrites umem->npgs with the pinned count so that
> xdp_umem_unpin_pages() releases only those, and xdp_umem_unaccount_pages(=
)
> then gives back only that many. The rest of the charge is never returned.
>
> A short pin happens when the tail of the umem area is not mapped. With
> RLIMIT_MEMLOCK at 16 pages, three registrations of an 8-page area whose
> last 4 pages are unmapped leave the user able to register only 4 pages,
> for as long as the user has a process running.
>
> Unpin the pinned pages directly and leave umem->npgs as charged.
>
> Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260421172951.A7052C2BCB5@smtp.kerne=
l.org/
> Signed-off-by: Kyuwon Cho <kyuwoncho18@gmail.com>

LGTM, thanks!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
