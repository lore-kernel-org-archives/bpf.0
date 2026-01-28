Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE6326927
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639701; cv=pass; b=ssY+749Sk91nlOfI3PTQSStm1AMT7HhmWPzRWseLqbliFj6jR2eGs7hzH77FCHOSxrxZOs004L1lEr0WQWtVpAcfcMtswHLGvoe5z4BZIBFCqmWKHz+Qjel6RCqTEW41DIOblbHZMRWmabX87Y5cOL3p874wpPpUUE6AsKH+xgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639701; c=relaxed/simple;
	bh=T4c3iVSddoT05c+TpiMovdeD0e9uxdfRSa2mtz8rdcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUg5/2UIovFuZEubFbxY8WonzJk+KvSGhaslTFf3VxzcwcpBBxlMANs4fPPM3Uq+hxuHcEI5SrR6a3xpP8vqCaMdVAgpB23gOA6s8FQXo9+bLHNK0CvaSsF3mb8Ju51ybGHAEuy2Z4WydSCQsLqe5PKGAXyzsobGjsTdtautbgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hep+3N49; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hep+3N49"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d18f80b5c2so227791a34.3
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 14:35:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769639699; cv=none;
        d=google.com; s=arc-20240605;
        b=ODP50dVQAj04DZE2wX0zYDd7TxPXRIFrJ5jpo+napOx53D44CfH4f2aJK/0JklHIDj
         /9aXG6y+edI5it9ODqlqym0kW1urxNi0WVzcfVYePvr7eWDZvmcrso2CyFdwT2YpCfnU
         I8VKxO6QeQqwTZKPqJ4tNBqglPOinQqyPj4NiWnm+rlQOZ+7kd4cRCXvlSm8RBsd/OYL
         wCOeeM+JCBjZwE2XWsnQL+qiE99hfoAXzKcuQrpL/iMy/YUI4lYLDiO8vEdYlUAOtUZq
         hOqzxrmelKArfERq2Y4FOPa6RCd5pO2SIvy7UKd/oxoNuYpoDHSwnUcLSzLeZCCdDKrd
         AaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PoIWrgGOWoR2ADTfr2zon4Uc9JuSMJyuA/FLzPv3E4g=;
        fh=OVHVW1RrriuyAXacelTYnrG560jQwC5z7XU2sxtJ96E=;
        b=eAsaR/uo+wBLcLslnIA+nC4bNgJ8yrlFRPvQeRw2Pda/82Ecm81NaNS85ECpHnHFF2
         SDlFl0B9hvpkDyZMWhGOaxwihMni1GSDSn6AsXZl7dHFjFMRFmPUg2SH+XrbCp14wHPR
         z91XHCN4x+DEnAV7+7SmKtQdz9+kDk0RLd6EUr/JEF48ySDx6l9ty9wlT6FVEzmoClgW
         AwHS4tl3rz6l+JR+pHklSaVQffM7du37tMcKntqmeVDsOCxYaNTe6QJzClRwLjFFnklg
         kogW3AfAmkSVYjaRVWqsYlp4dzLoE0nPA764FURD8ZqpLPA6LSS+ZVtJ6rhKErs8bJzV
         ubNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769639699; x=1770244499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoIWrgGOWoR2ADTfr2zon4Uc9JuSMJyuA/FLzPv3E4g=;
        b=hep+3N49/KL8sIa/4Btrobzwx42EP31pzE03WiBKGSxngiR+LTni04utGg4bmIIaui
         BMAK44J83Cak3kAP4aOjaStaNOP/a7qaq7Y40xVuiAca5Yt7FXVv9T42IhfzbvnN9c6/
         d2xOrBXIaafZlBXELP+YoiLKosd0k3v5GCv9aB2uCkumQJ7aQzC9h4WjabZfxp0K6Pzs
         dlT3CMlD5cVwbPnH78mQgz2xqO9X2riHl6JLhPfa66c0ReIGnwu7OvUzcKiondn0dfM/
         QFCvLSOYTwCiX1/eOsLc5GK3FcRmTZuIuXkL4aKDBOKleIa4aCHFBeDdC3sawAmqIkh0
         rlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769639699; x=1770244499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PoIWrgGOWoR2ADTfr2zon4Uc9JuSMJyuA/FLzPv3E4g=;
        b=fF4aiqiFqbqYQnuoNWWBQTor//LyQFHxhVZaiU9YNh1/xOsZJ4xGEMX2/f1Yu5KkYT
         6/CETPtkKmUzsLrQbCyIX2leAs6RcYV/D07XexAg2LERu/G7vNCMXuKz3o9F+Qf16cfs
         W3zIX1lUfleIpVGN0ZLnW3jAl7Gv3wfo+5wnsC+XhgmVEC2whk59E9DCc0bwGl7mT0Pl
         hqbsv4fB/BkDNdU3q0izoWG8kYG+PDgD1+DLppn07dJX24rPDoyc/vgpEIrXTNBTkjJI
         9lLeAo79qDRX/zNjVdXjhRBhrTjLsE/QhAS79OZbHWDtU1OvoZXl95Y9tde6uSEZhjT1
         R6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXS4lPuxu5sHyE3OeByt3JCr9u3L4ro17c0WSHZITUyiwVRWK/9BOziuEMFhr5GYqr+1OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92w9VWnAmA3sYcQDJXX9gcr5vNYARHwZ0VmLC/uPuzM5OkPAp
	IfNj8uGrDhHc+ZDj56wYt37AOkSuQE4zGBHAeXoSksyPrVwL28RQgDbPmYseByyVZezPNUh4NwU
	XPU400GtLZaY/VxVA+bs3qocFeCunYOA=
X-Gm-Gg: AZuq6aJMBaeA8Vq5OR7wr+Yh0u8mtl8pQHmmrGJg1ZDf8ZcUTbrTAJim4YKGTFXDC3j
	/gj+94/Fo48GXC6Cb7rM+eui4JTmpueL5CK7p8FhdgXD63BRM9mmZV71zx7nEobig+QecUDUz+I
	mBn+09JLEdgnVqHyDr35Nb/V7hdW+/ROlqgc6xAkKC5wkcZixF6htp6TCNjTRAlXWfjgoQ4jOkL
	lf5k7+CvKyBigKCZuFym4RVPZJc3IeWtUzftDe1W8IGSM3UqlSI6Z5V7MwdW0dfTfI6XdngJndO
	2oif3Cs3PwaJj2aLsyPVezcjuyqz
X-Received: by 2002:a4a:ee0e:0:b0:65c:f545:c05a with SMTP id
 006d021491bc7-662f2048020mr4358797eaf.27.1769639699382; Wed, 28 Jan 2026
 14:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FFDD6CD9-5100-49E6-B3B8-F38099043E87@amazon.com> <76564BD3-B685-45EC-B53F-06534512EBC7@amazon.com>
In-Reply-To: <76564BD3-B685-45EC-B53F-06534512EBC7@amazon.com>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 29 Jan 2026 06:34:22 +0800
X-Gm-Features: AZwV_QjDlfRMv0KQKKWP2gkRkHnGfGfmqRNVLTQ_ZpvT-etoTOs890LpyTx1UI0
Message-ID: <CAAXyoMNi3W-5VHWgr8L-gmbR2x1e3p=vsr6CdjKV8XfzLG8JsQ@mail.gmail.com>
Subject: Re: [RFC net-next] net: ena: Use u64_stats_t with u64_stats_sync properly
To: "Arinzon, David" <darinzon@amazon.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Allen, Neil" <shayagr@amazon.com>, 
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"Bernstein, Amit" <amitbern@amazon.com>, "horms@kernel.org" <horms@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "leitao@debian.org" <leitao@debian.org>, 
	"Enju, Kohei" <enjuk@amazon.co.jp>, "ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, 
	"mingo@kernel.org" <mingo@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 9:21=E2=80=AFPM Arinzon, David <darinzon@amazon.com=
> wrote:
>
> > Hi David,
> >
> >
> > Thank you for submitting the patch.
> >
> >
> > > On 64bit arches, struct u64_stats_sync is empty and provides no help
> > > against load/store tearing. Convert to u64_stats_t to ensure atomic
> > > operations.
> > >
> >
> >
> > We would like to run some quick performance tests internally before sig=
ning off.
> >
>
> We have conducted initial internal performance testing and observed no me=
asurable impact from
> the proposed changes to the driver statistics.
>
> > > Signed-off-by: David Yang <mmyangfl@gmail.com <mailto:mmyangfl@gmail.=
com>>
> > > ---
> > > RFC Comment:
> > >
> > > The write side of u64_stats should ensure mutual exclusion, however I=
 couldn't
> > > find the synchronization mechanism in use (for example, ena_up / ena_=
io_poll /
> > > ena_start_xmit). Should this be considered an issue?
> >
> >
> > We reviewed other drivers and it looks like none add extra synchronizat=
ion on the write side.
> > Adding extra synchronization would degrade datapath performance to fix =
extremely rare missed counts.
> >
> >
> > You've submitted similar patches for other drivers but only commented o=
n write-side
> > synchronization for ENA. Is there something specific to ENA that differ=
s from other drivers?
>
> We're still waiting for your response to our previous question: You've su=
bmitted similar patches
> for other drivers but only commented on write-side synchronization for EN=
A.
> Is there something specific to ENA that differs from other drivers?
>

Hi, the series is suspended for the moment, as discuessed at
https://lore.kernel.org/all/CANn89iK9xfvQ275f+PPht8mM6K49mUq-T9D-4UUxUkTncM=
4tRw@mail.gmail.com/

u64_stats says: write side must ensure mutual exclusion (more
specifically, updates to the syncp), or one seqcount update could be
lost, thus blocking readers forever. I added a new u64_stats update
block in ena_fw_reset_device(), but I could not find the lock that
protects adapter->syncp, at first glance. It would be totally fine, if
all calls to u64_stats_update_begin() are actually guarded by RTNL or
something else, including all indirect uses from ena_increase_stat().

Note the issue affects 32-bit arches only, u64_stats_sync is no-op on
64-bit arches.

> > > @@ -440,42 +440,42 @@ struct ena_admin_eni_stats {
> > >     /* The number of packets shaped due to inbound aggregate BW
> > >      * allowance being exceeded
> > >      */
> > > -   u64 bw_in_allowance_exceeded;
> > > +   u64_stats_t bw_in_allowance_exceeded;
> > >
> > >     /* The number of packets shaped due to outbound aggregate BW
> > >      * allowance being exceeded
> > >      */
> > > -   u64 bw_out_allowance_exceeded;
> > > +   u64_stats_t bw_out_allowance_exceeded;
> > >
> > >     /* The number of packets shaped due to PPS allowance being exceed=
ed */
> > > -   u64 pps_allowance_exceeded;
> > > +   u64_stats_t pps_allowance_exceeded;
> > >
> > >     /* The number of packets shaped due to connection tracking
> > >      * allowance being exceeded and leading to failure in establishme=
nt
> > >      * of new connections
> > >      */
> > > -   u64 conntrack_allowance_exceeded;
> > > +   u64_stats_t conntrack_allowance_exceeded;
> > >
> > >     /* The number of packets shaped due to linklocal packet rate
> > >      * allowance being exceeded
> > >      */
> > > -   u64 linklocal_allowance_exceeded;
> > > +   u64_stats_t linklocal_allowance_exceeded;
> > >  };
>
> Regarding the modifications to ena_admin_defs.h: these structures define =
the hardware-software
> interface between the host driver and the ENA device.
> The fields are specified as native u64 types to ensure consistent interpr=
etation between the driver
> and device across different architectures.
> We're concerned that converting these interface definitions to u64_stats_=
t could potentially
> affect the structure layout or introduce subtle compatibility issues with=
 the device.
> Since these definitions represent a contract with the hardware, we'd pref=
er to keep them
> unchanged while accepting the driver-internal statistics changes.
>
> Would you be willing to split the patch to exclude the ena_admin_defs.h c=
hanges and any
> code that touches these hardware interface fields?
>

Sorry, I'm not familiar with the details with the device. If they are
managed by the device, load/store tearing should not be possible and I
think plain unguarded read is enough. It was unconditional use of
ena_safe_update_stat() in ena_metrics_stats() that made them
suspicious. If that is the case, refining ena_metrics_stats() and/or
adding a comment about it would be better.
