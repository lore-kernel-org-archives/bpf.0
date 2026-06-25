Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F10E331EA0
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394768; cv=pass; b=t5C4Qk+hwdoP35zsE2orBhFTSZEipH3IFpFsWd2EXlt/PP9GKDP/pp3dgrMp8b57vXY0D6jkpm+UwqEbXIzV8mRHUrI5x/tsS2UO0xNdvCGhg4mGWn4c0JZCE5k8az+hVodURgW4gQCXVmjrW7kVrJ9z5l/5noBxMVSn42W4Rww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394768; c=relaxed/simple;
	bh=OoFzKZW407yRUv5K0dGZKSk0BzM1rVvgeohYpJyht7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPnG0bwl0Cw5Gol3wjFm5y4XqUhBLdaMVkreyKDubP1IVf/jUTbeHE0r5Cbp4HGHgETUuDS1ABjrhI5ajiwScd1TD2bABS4sWyeLXOf38izoRIJfYZnczLPIo/3b6ltdX43r/Eqy0tKtMBm1ie7DmR1mZp3b+vau7j6fbIMvohk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FddRbWzi; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FddRbWzi"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39ad188f6d8so5124031fa.3
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 06:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782394766; cv=none;
        d=google.com; s=arc-20260327;
        b=JLbIzuQvSqztIHMxJTvUcDG4pOeZqPORzIlOA3Y9IRaBp/x4D+MOJczAJiupBSKti0
         LW7XqhjssYvsZfIvoSbtTIcMFSsZVARN5+7CA612gkIcN4F0JVcp7amWSfreVSeyTUyM
         u52AadbpNeNaVtm8cuC41KpInih7o3Nzh5m4GGLY6I8u+klqQt8KgAZqa0iBOpeVdMmV
         bPNdbYY0BFLG59it2I0nUrwbKu7LnFF41oYBGT4yFG4Z6SkpLbRLXkWDEVDs/yyQa/Wr
         uL41QasQLwtfJuKWMbraUEZoguoQ+5gzQhvylidMAPKGmzoFa6N08qJw/VbUJeHM6DlM
         9BTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OoFzKZW407yRUv5K0dGZKSk0BzM1rVvgeohYpJyht7s=;
        fh=85L0XP+WK3+ooWLcD0ahstyZ29Xo9kP2HtThziZHTF0=;
        b=TbN0BOm9KKxHeaK1xck+BarDqBlQYQ/lnfiT31zjPR+irM/7/aVQHe/8X3qN9HkMse
         RR0iodrL9V9+XbSki1Hvy6/eN2wLAgnJ2+D2IZ4QHXN+UjqEeui2z6lU2P93eUI+FMan
         iTKvLh5YjXnUVKggxAIsy0QAwo5b2kLrRZa3nP/67zPj9IsPXomPtrcz+f4h6Q0EXXdS
         /9DddBDIoPsHsf0fwaoDxAerTixtYrNz6pHfoPNEwlwRYrguDGXZWDlnctSo2LVKJvtZ
         S9gx07QYhKwID3PmoU63VQjujzelR4kswBYJCCGMlMCYHobhHbvgm0l1lXbrq1zFU51k
         efVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782394766; x=1782999566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoFzKZW407yRUv5K0dGZKSk0BzM1rVvgeohYpJyht7s=;
        b=FddRbWziEAG1zi7AR9eeHcojKvXKJ2vMFeloIRmqCrfmcedh29jerCXj5jMW7KWv+4
         qn+bdXlrYuLyX413az9wASfs3768Pqpn1XTSP7pT02s7BGDc0fhuyZoZH03rRewWG1+M
         sBb7TyBO0VurkvwAuF+ozARFzs0bz4JBGuG7HXVEWk2RGbGiTrf6cu5W4pXgyscXhP1A
         HMZgmcJmSPV/6XJ88s2gHIHgLjcue0qjhHUms5X11636903RR2TIU4U8ZRsFw7KV2BZh
         DEt6w/88ZzjvPCVj5+1N5BmwxGgPocJERuGzKpwcxDARrIuGcAwpW7ll4MmfG9xCgumG
         VmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782394766; x=1782999566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OoFzKZW407yRUv5K0dGZKSk0BzM1rVvgeohYpJyht7s=;
        b=Yu9ntaUSEwa0iL3NkH+SxSa3xvBx85IES0Zy9BeJGOmr4GT5/tyxhH6J2LRPWGx9QS
         VlXKcAJ3hHzViN2aQiwEapmLxWr2eIDbcsSYkrVLWF7XvejVagqR/pCaWUD2J3Ollh4m
         NAGNW2W9rk0tYuFTPHjqtGH8VxP353gkqi80/N3/m5WAzA+NFcrPEWyzCaUjnJRPx3dK
         cBBctPIhfhMeElXbqdljwVPTG+pcjZUVgL9t0iJXnZsYMdL6ZYjHMNt7cMRA4A8IY/9l
         Tv+VuRLaXtBoTfT0hcaIWjZ0ELALEVlsVxVKrOdXjMIjp2GqxG7Yrq2kIx2YIsMN+wy+
         75Xg==
X-Forwarded-Encrypted: i=1; AHgh+RpeWohIjUymiy4FJZCrPhTIV9eTGyaT+f/xd6i4NHbA1iiCRAG3uVbnBKSl2rrUjGw4O28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNOoahi49h4fa8c2xWaB7qtgVkQfElluLzKzK3GrI8s+P49Hds
	AuRE/EDBZSU5Vpf6csdCMnQDFahBiNdOF56aX8/kFVeJgpMmrrbx1C8I9jiJbVg4eiTouT0DC5N
	SwRC5htt8dCh5uHyACnxYvWJz1XAHTbE=
X-Gm-Gg: AfdE7cn0y4YHwaEDWcl4caqmJ15hZJgOaxKQ7NMvhZMS62jpLA4NjXbCzVjCEfa22Ms
	kEEeQgT46p1dHdYar3mQ2QZ2SyZPuyECJ+bJ4yYWWBD1ZOhke14cZVfrv1PW5CjFgNC26baDeC8
	DmPsOBzpHmEwweQfzaVWy+XXggzbY0btsd4ek99poQ4la3qQYXWlrPjdSMkZPeSiVpoVrd7XBqi
	UsxZai/MjT5T0d07kWTDUPIo5Pq36NhMtXo/D3R1xqPmHsp9sXvoyS9JK4iBqwu5S6PvkENx0js
	uKywjZV+Jzi+mnbgnm1H34MxDiA4HkSn86Xx4TGhS+ZRMPod4D7s4ygSAy99Mv9dl1yDcjSWWSo
	iNMDTxV7i3w==
X-Received: by 2002:a05:6512:3c90:b0:5aa:753c:d8d2 with SMTP id
 2adb3069b0e04-5aea1f41685mr1232020e87.17.1782394765560; Thu, 25 Jun 2026
 06:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 25 Jun 2026 21:38:46 +0800
X-Gm-Features: AVVi8Ce4AOVQRSewG-fz9uEpHoqOhw7FutDh6vfdNCI-T3sJ1cbdoK4T5udzXc0
Message-ID: <CAL+tcoAosQzMo+4YJ-F_4SJaos_gRpQsQRETYPqBS_hJzan4sA@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	tushar.vyavahare@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 5:10=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> The UMEM state refactor made __send_pkts() use xsk->umem for Tx
> address generation. At the same time, the shared-UMEM Tx setup copies the
> Rx UMEM state into a Tx-local state object and resets base_addr and
> next_buffer before configuring the Tx socket.
>
> Passing that Tx-local object to xsk_configure() makes xsk->umem point to
> the zero-based Tx allocator state. This breaks the BIDIRECTIONAL test onc=
e
> the roles are switched: the same socket is then used for Rx validation, b=
ut
> received descriptors from the other logical UMEM half are checked against
> base_addr =3D=3D 0. With the new UMEM bounds check, a valid address such =
as
> base_addr + XDP_PACKET_HEADROOM is rejected as being outside the UMEM
> window.
>
> Keep xsk->umem as the shared/Rx UMEM view used for socket configuration
> and Rx validation. Use the ifobject-local UMEM copy only for Tx descripto=
r
> address generation, preserving the BIDIRECTIONAL test's intent of using
> the proper logical UMEM half after the direction switch.
>
> Fixes: b17631032769 ("selftests/xsk: Move UMEM state from ifobject to xsk=
_socket_info")
> Signed-off-by: Maciej Fijalkowski maciej.fijalkowski@intel.com

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!
