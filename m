Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB653BE156
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784200986; cv=pass; b=WoxZOEkXaseP7xVqNGiUiV0QFyK5FXOZY13JLvgJezYGBTGmw/vX9QOS2MGtCuc/LEwcw1qqpCyaoYehgdB9/mDWejQA/TI8JkxdKuukYsctZjb9ZtS8nwb7+ibf8riANxATrUBenu6f1871k+DYgdLA89S7z2jfaZ9eX2euCiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784200986; c=relaxed/simple;
	bh=oYH+zCykP3nxD+dABR4pixhBxWPbhrc9AVW3gh7xOi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGAvQ2M4JPr+Skw85f000GJB6+5sEIPHesVS/+vwOyC29bvH63k9C5IRBhkG+QNoeOQQzq1hG/mkXQRFhgo2LVbmmUZ51EGOELzhtaLwV7pajoNp8nos4WoLUhek4B220id39NzChh+AGTQYk/ul+KSo+rgTg59RcHs70VZW3CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMK/DjKM; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMK/DjKM"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dcbade417so4687218a91.1
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 04:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784200984; cv=none;
        d=google.com; s=arc-20260327;
        b=lQmB6i3pfpjSAnhUjtoj1z5ozrQ2WsIDyp8a7/FJLLmtzdYddDeaqpO+3k82tFtTVF
         UfeL3agE/1SEyI4ty5RuGnnF5VC/cwqPjNEDVLJiTRv1YCEMTbM9qNuXF+ci1/C4h0kH
         uiD2CFMZUHpcDYdYZxSBTAR3d7TH3R4bbwlXTz5A/G2srdM9//jaqQQ/F22kedXFpn/M
         g2kxzHyJMhnTUestOdanEg/oOLxwdUgjhhM3uhAJ2ZMXyGg5onXOwUeNbzdouncZchK1
         d0h4ptnmkCPC+Mw+xf6xlV26ogt+/Gu1oTD1P+A7G07N1aEzImCO+0fdeGqhLNMAcUaD
         CD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bbRrcnov8km991My2tmYBPDRYU7T4Dy2j7rkUM4ZkWo=;
        fh=HuzHeZfWtiomWHa9eMt2D76xEOcDr0r8L9UgCgKCFWY=;
        b=OuerK1wdUfga6g/1Fl8KnId+PiSbV8oT/vKK9UVY0IkpPEUSTz161VDzEJBld6Aoze
         RdXQow8LQHGbCqsLao6IP+3i6gOJRIlhRXrkSjZt7DY6n9vd/ZAKx2yb5BxDx2NYU3a5
         Fy8bkZr3cM90HL5PRUwamdXZHxtsvfZeHa7C0mUaVzMVqJeB51BA4ya4/D/lU4APA1tr
         GTbzNYRiY313QcOkDcyOO0vOqEUc3El4FrbUoCWGyFxy6wRb5YV00tidifrIie9Q6quF
         dTKpfdnFQZYvH8JqqOSYhgFO722TMSgjhtZ/3hC5XMEH+hRqCmOT0Y+zBvEYXi0g/NSv
         Yakw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784200984; x=1784805784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bbRrcnov8km991My2tmYBPDRYU7T4Dy2j7rkUM4ZkWo=;
        b=qMK/DjKMBAQMAfvWlS4z7kSfmd3mkSWCFVreY3MyVWlLsBv9TkG+nHTqT/m55aNTWa
         3d12mpAb0ToCmlMxALLYr82NYP2WW+7CnBNdUbhpenF8pf0KV2qSbHWikY7zX9O0OIi3
         88pTVkXvswicG+ixEnAEgdAV3GuM9adrV8ymq+lZAtCbBHgH/Uzl5EWEQ1DhoBNiQROn
         keYFmqKiNv0SlAEIRHrZ7ugMEKR+9HM1Fwn4u6p3ir02jpiQWV6fEklnN+MXk55xHdno
         7ukWW29lLW9iEBmJYwYiMBaXkrifpiiN3klYI4aOsmHomOxQIZKlOUcGB2i4dEKw6+XO
         S+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784200984; x=1784805784;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbRrcnov8km991My2tmYBPDRYU7T4Dy2j7rkUM4ZkWo=;
        b=GEMAoj1p1Hr/7Z7KpaVMWb4M4XnfkEwIjFmtNtCPnung6gxflrIHZk+4M+dM10OSYk
         ynHh5hENF+8ldpzPqfE/lrcV/kZr8DD2rdjgzE/EIKTjHyDb353Hml3mDzrmX06d8Vz3
         kX0X2TFyMEnT5ESGOjEn1Um380VU66sJlk6A1Jw8cfOWAunjYFZTH5LjeMG4d2aFOdGt
         +TFGRtCeXC/MBUgCJhLiLCwt9PyUPdQ7uoKGFnyB55aqcOgt29Sv5YVRvcBuOdGMzTsL
         HzA+687RUnKVImRMXutLVElg5sTvVR2O5js5d3VbvFR+RV62nXbGEJuTlOjGdUhMzkFY
         3nFQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTgv765T9p2ERjs4iZ0bjNKgWWktba5e6mMEv4azvzlyitho2z19hbHzeSmLP6BbFsnEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ8jbj36ZWLfh7JgOcn1V+2QaFvv2Bj+b1y6XtWc0Pv5tdJfhl
	GzzGAm3/pzMbcJcaKmyk5ld9AK0Nzft0oJQhA1EBaUO2RWdSc15ghIMawSPe8hMQY4PD7/Anvfs
	wbqohiiVQqD65y/dxrvph8te/cO7RQv4=
X-Gm-Gg: AfdE7cmP49byQJZLxEYqe1e1HB2gxqrfJM/Ghgk+Rro6Wt1oMxmSkUaMOFKPgBO21tV
	KDTUjfifJE6ql2Q2JFnkIYF19y6Awx0P4ag7Ve3ywvl6WfwUiVwTBligDjvHYSlZZ/XFtfG/k+O
	qS3TNW1ikQZmtO7DVrdoA/JZxqTJQ86KKC8tmPk0TKFUR0N98e3r9AHrm7J4uYOmOigufzdwqHL
	Da94GToseF394DmsAv48Evkd8oGYbCOrIPwPyo9o0RN2VObHf+apfuU/cWLoWbkmzsNDxrbxqss
	LL9Xio62D4ZfflWrgHE4QHadhbuB8xowAiWCGzTc3fkw/eg1IDzvJTlPOrq8p3ZpQkSu2kgxldd
	zA/U5JhQpxwXB
X-Received: by 2002:a05:6a21:101:b0:3c3:9b44:982d with SMTP id
 adf61e73a8af0-3c39b44f10dmr569369637.42.1784200984341; Thu, 16 Jul 2026
 04:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com> <20260714140722.111645-2-maciej.fijalkowski@intel.com>
In-Reply-To: <20260714140722.111645-2-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jul 2026 13:22:24 +0200
X-Gm-Features: AUfX_mxz84KquZjL3HAxXADNfyK7IXrd8-N61IqEcDyytdV68gZc2xvlnpmcRes
Message-ID: <CAL+tcoAc7d8MSCqK23_pmL2G8tSS-MpfM53brijPntv5A+BA2Q@mail.gmail.com>
Subject: Re: [PATCH v3 net 1/6] xsk: fix buffer leak in xsk_drop_skb() for
 AF_XDP multi-buffer Tx
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:08=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> This patch is inspired by the check[1] from sashiko. It says when
> overflow happens, the address of cq to be published is invalid.
> Actually the severer thing is the whole process of publishing the
> address of cq in this particular case is not right: it should truely
> publish the address and advance the cached_prod in cq as long as it
> reads descriptors from txq.
>
> The following is the full analysis.
> xsk_drop_skb() is called in three places, which all discard a partially
> built multi-buffer skb:
> 1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_FRAGS
> 2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
>    the TX ring prevents the partial packet from completing
> 3) xsk_release(): socket close while xs->skb holds an incomplete packet
>
> In all three cases, the TX descriptors for the already-processed frags
> have been consumed from the TX ring (xskq_cons_release), and CQ slots
> have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
> which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
> the buffer addresses never appear in the completion queue, userspace
> permanently loses track of these buffers.
>
> Fix this by letting consume_skb() trigger the existing xsk_destruct_skb
> destructor, which already submits buffer addresses to the CQ via
> xsk_cq_submit_addr_locked().
>
> Note that cancelling the descriptors back to the TX ring (via
> xskq_cons_cancel_n) is not a appropriate option because an oversized
> packet that always exceeds MAX_SKB_FRAGS would be retried indefinitely,
> which is an obviously deadlock bug in the TX path.
>
> Also move the desc->addr assignment in xsk_build_skb() above the
> overflow check so that the current descriptor's address is recorded
> before a potential -EOVERFLOW jump to free_err, consistent with the
> zerocopy path in xsk_build_skb_zerocopy().
>
> [1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.o=
rg/
>
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path=
")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Maciej, maybe your tag is missing here?

Thanks,
Jason
