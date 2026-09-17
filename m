Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6814A99DD
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636207; cv=pass; b=lvJliw0DSU0jC+Xe9CM3AUCVdSNLsRjyQcph3CGgkPFnTUxo4HDcPyt0kTDtpoAL/muSo6u3jeLIFMU/UMgRwShajVrHGjBojKIA8pKgNpwPC2af1dTXKPWGKz4OpUXEZQfruIIiJ/DHh9G6112GdgSF8jiWP1aKGjGdy+53pRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636207; c=relaxed/simple;
	bh=udW6TvHFa4OCP2Q24JS5DX140/XFneLVvF+vPzrl6f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJKB50oEb/7kSnAhYvehZxQntAbF8AHW8Y0jx6YCZEoeDbcIYUqmDuOI8M9H9mK26m14sQxvjLgOEYBfYC2mnkbQ06Gfx+APCRyWyDHv5f5N1iDHF7zxqyUUu6Sp0Wtln1WESIVVfAv5Tpk25vcdpApWoE5qSSLyFw5KF6GqZUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6Ifo7Jw; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6Ifo7Jw"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a5e548cd7dso5028021fa.3
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 02:10:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789636203; cv=none;
        d=google.com; s=arc-20260327;
        b=msaAqXSpejkrqbOTBeGeeIgPaTsRPfShr+PyZ+nbE89J8P3BI+/1YW149vVGgYflwS
         qbFlJS/ahxXTIGehS35VWXE54VkXcb9zuI2z6iJ4GnCoAOsMKbKBHoLmXbribMIKolit
         CEUoklx70qdq+1JiWrxuIqezeFjKXBqAUonz/CurbkUFNKZ3xzr3ZM8b5ebzDzqOx6Hs
         svydktx8Kc8W1HhK/DP/5jLMqU8IJRdJH+hfrYnUd+7ueiGgjN5AtKMf8uJr3vo7TKh6
         3CEqGeVbBavjS9QicLPbS68iVuz8d/UFrb+auZUa31lxs3LXqDjGU3pCZzfDBKvNS9dS
         +AVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=udW6TvHFa4OCP2Q24JS5DX140/XFneLVvF+vPzrl6f0=;
        fh=zFeq+iAYGeiKNU+y2IvVs97QQaPpIcvcdmxRoWkv7sg=;
        b=DE+lIdFOO5Gsq0opPvB+YVpu7ehgHTzp0CaLOA29UhzSXbENkjAx3HOID59Eox7emN
         uAgpPilF2e8ZLlYxctU22lahwunSElXFENZ7yAmaEeGHgktxuasftGrkfxsdUgU0j7wl
         nJbIQEjAuWfz+J8cokDz1++NrHFvV//zabvbE2JdoV2PbHB9bg5KUK9rQqh12izmTD0y
         HX5jCWqxVhAN5oOcQNkeg7o+fs4SL5GKaLiz52y8+deqjGAEhjnQreHyH10RZFaDSzO4
         me5WCTduC+DknsH8muFEUDpCeiJtUVjTrISQ7pTwYhODohZTRJ/LHPn0giicyKlDhbH+
         eBZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789636203; x=1790241003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=udW6TvHFa4OCP2Q24JS5DX140/XFneLVvF+vPzrl6f0=;
        b=d6Ifo7Jwc2mDnX064vN3jwGMqKHmX6Ak2vanxFtOvYK4Gz14acxdekb9IoWD1DrJRB
         OA4zxp8XuiTWiHuKOcNC/8GBDaXewWNf3YOfwv4vqVaKVGknqr0f9HTFoWm6m+LZnyuG
         BUysljPeXCM7vHL64dzc/dI9IWph476W1pz8LUjyKlpOvD+WGOnO+j1mQpuB2Y4Y/csv
         Totco+Ppa/2T1hcUwP/DrcEF78SiZ2hYYQD63Hlc9FOVaiWShl4bSb25EZ21RPM/Hv6R
         vVr/gczTOfjb+EwYmMA44QDbOYGhWufYNKc5KqBpoQLEhc3t/iegJPumHvTBHVdi1wUR
         oOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789636203; x=1790241003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=udW6TvHFa4OCP2Q24JS5DX140/XFneLVvF+vPzrl6f0=;
        b=HXVKYCRhuQl9Rx3iOrzC9Y82yQregpBZ26FFjcnBMBi1V9ZFJ4ylLr28g823FxAF8K
         nDkxKxP1srfAQkAmGdWKxY/PRfQj6w7T9H2Vc3Y3y6YkVO3sZQZbJ9TZvbik+J1VsZKY
         fEQGwhKl2CCWQ9ozZZ2XzdYYzAIEGO93cmimOOU4acFRBZx8B50V0wJrt/7Mrs0ducV7
         edJ3Ha453COHtkvH2pUAB6nLhOJoE+sZgAvQfA8Rzl0otx1F7cRVr1u3NVgwlk9O9kfD
         fdWfbaqPecRp3jif71yy+ifBxrtHTZPqSJ8lkP482gbGpuGiEzyBiKI3eyrqfS2enoFy
         OgPw==
X-Forwarded-Encrypted: i=1; AKwUvBx05ORn6tBL9GQSUMCnZ9FB0eB+RStgMRjzYWe8dE26JKc96mxf68L5NmWOEZW6FUQHmkg=@vger.kernel.org
X-Gm-Message-State: AFuF++mx2qXqqPg1W7htp9M3e1p7u9H1IECWpR0/j9au/sHh5jNe+ysB
	m7QEq89VncHN+CH9d6ddFpZddui0yKWSi6seQb0v/L/Txq2eK+FBm4U+pyxwAMHXoXZ7H08SYRr
	NMmJmLi1D3I2pmOash2CnObVqRSHEpG0=
X-Gm-Gg: AYBFou2fpyI2atoypMPJnveI8Ht5xMBMD+OEcBy/kZ2xGJPrDDB86+qa7pImaS48Ua+
	kCbxpowok5bYkvWVS+4AA2k3J1phgyw9lprQKfXNX4GCYvIeNiaeCG3pLCOp02o97ajAjwy5VTH
	vYtFEdmYnsF1krVyQJLIXNiBQHb3HjOIKeirnsmH3a8S4CdIeWNzORA5hMsGaxuslquGP5gkXdy
	PFhTinVybs1wY4gcA3BxUwhHgiV+FmcSAY/2HjKr267l504lBUncWr1mDZ//b5n30EJtlqffJeQ
	YymHYB1hiV8Q+T3f/0b+zoVAZ9RmqHbqFAkbNXE9opliXNS6O2jeXMdYtt9ZGBcjZi5y7KgBMPV
	Mf8wRxnbKCwkcteKFiybDMdfI7StFwuufHOGcpJ0ZqDlNYmfRoIWgTz1zvOJ3YRZre3DF9g==
X-Received: by 2002:a2e:be86:0:b0:3a5:b6af:2973 with SMTP id
 38308e7fff4ca-3a5dc9a775emr21702761fa.5.1789636203298; Thu, 17 Sep 2026
 02:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aqPxxX9MeGmAqGy6@boxer>
In-Reply-To: <aqPxxX9MeGmAqGy6@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 17 Sep 2026 17:09:23 +0800
X-Gm-Features: AcwNN1XR4DoliEuKB5ZbfjMKqsAIYGrJKJjFNjGTy5tmlhsxxcCabhbtEPXZn8M
Message-ID: <CAL+tcoBBHQpK5GruVbLJviTFBm8repE=kHt-D+PHWJ9mCwQbYQ@mail.gmail.com>
Subject: Re: [ANN] AF_XDP office hours
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 8:21=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Hi!
>
> We feel that there are efforts on various sides related to AF_XDP
> development so we thought it would be nice to have a mechanism to have
> cross-company syncs or discussions.
>
> Therefore, let us introduce AF_XDP office hours. Plan is to have a meetin=
g
> every Wednesday 9am pacific time. Similar to what BPF did, we're gonna
> have a public spreadsheet where people can put topics for discussions:
>
> https://docs.google.com/spreadsheets/d/16GL6AbdjDyT81cJ3-qUnYvFxqO-RlhtYT=
S68bfQQDbw/
>
> At this point we are planning to meet even though agenda is empty for
> given week, this might change in a future.

Hi Maciej, Bjorn

Big sorry for not attending the meeting. I miscalculated the time
difference. I thought it is today!

Can any meeting notes be shared here so I can catch up with you guys?
I'd appreciate it :)

And I'm wondering how we are going to deal with the fixes (about the
header) I mentioned previously?

Thanks,
Jason

>
>
> Thanks,
> Maciej
>
