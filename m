Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFAC3E9C33
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791490244; cv=none; b=SKefzzDU2ZEBh6s/HC6rggq58810th6jBPZTzcRfWCD6fTccLbJ54fbsWw3FJRIu1OvSKe5FhKWqOGr3prXwRi7xEv/LlDkvFj2v8tLbG7vYRrim7AVjXV9VgIiF9P8+Mu7hyz1ur+HEhFcSMAa2v9mtTepy0Iwa6x32TwKYk/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791490244; c=relaxed/simple;
	bh=yF3jq0/vOMO/ywfXfijmGEGeer2JbGwa3Sl3cQeG6rg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ayoOA6OEfMaFmsqwOrs5xlGqCeMPDdVsLnKR9JPoFdeZCdb/ULNNuEvRdSm17fkW6X/xuKuxWcLqaqjf0/EkLo8/9wBw9ppm+wH+nojRsYRMBoJTcC7w4WgHVgBHTAYT6FE2O4Pt/vd3YDoGBWKWrci3bapPpFsew93uJqDTDdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITVGTowE; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITVGTowE"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-81ba09a5d23so5585964a34.3
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 13:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791490238; x=1792095038; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yF3jq0/vOMO/ywfXfijmGEGeer2JbGwa3Sl3cQeG6rg=;
        b=ITVGTowEuCGrUhGyQkFFfBAOvx/LzqeZsm73DAy1g3A4EsCiHo37mqaYA5RtA7Vbvk
         Ozk2gG9Mlzg4SA1fBJmePtmZoNgNiY0Zna//6hWjNxe32msLWNvtfl4v0PZe+gVyDpAM
         6SAuv2vZYfR+tPHSDdJoWKAbYQspmL0kSzV+ZVIT19od1ITy3zkDeZRK9ouShZtUPutP
         4LK2U9bIMAOwgU5xqWJuRogo018tE/sp9HoqNUubX3v5iUiqVVaUxuNYuqW9vJccc2Cj
         O48QrYPklp+onThbzOVFvq42/IeHxbOieudBGJ8YjHGeKokxLz68k6H/fkixznBGakVt
         1VtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791490238; x=1792095038;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yF3jq0/vOMO/ywfXfijmGEGeer2JbGwa3Sl3cQeG6rg=;
        b=lt7gDdvqPkmOEs/4cONBpeW6XnU3oHwcGYJehmjM9Mevxsy4bMfGHpVYfd66cQyefk
         STCdw60HWbUQxfq0NLyNTY2NY2vRjiSSBE123W1u7SrRKRDBVdLRM2jVOqYiWuaMK9MJ
         xDH+p3lvrmIpD9GfkG829s8jTbfQySydyhgQ2f6102eQ+s6yKTPGk1JMK83RIToHSCrL
         mN0PNu7qacv2ye/YV9Pgh/pR0WBDAxeti5SfuJ1EBfrXRyCiXgDSs4TyaZ0kVscrhRSn
         XtH1vr9TXWbNpmQ9z2yROozM1vZ326duULLdpqviGLXd5V/CL4EkCDNus2mzJYrQAHte
         RRzA==
X-Forwarded-Encrypted: i=1; AKwUvBychpHQbOmtLhn8zPb0+YFMOQu1Jp6qgFzJt2bIijCWNI3Up7AFCUOB6KV0mis4X7XLZ4Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mAbCpuQlZSRwV1CBG/0S6tNjtSeUT9e5D+fY35awhZSnkjnBEM
	wblUy2PGnPNBgYwdOndDj7zhZVVjXd/zxuq9akzW8+HGpoAJ6wgffo0p
X-Gm-Gg: AYBFou2hJqD+BCbpV4Vm+UC1gm2mCM+SMmU37/2aZTySi38lJYdOwlq1oRgi97qtQ6p
	bSnzc18ZwOEwEoSMXNQqA7vacP8zSfKPq6HWnnL6T0wz3w+ygePtqGT3bhvyJbPsWSxu1kdP5Fj
	pP++Qf4w7nF387KZ8E6SPOTrETWk5UzVUj7TGdWqkEf4PqxNahQtHSyZtpzNzOQNlxD3K3ta8YV
	OksfSvOP3uzTeQ/pYrnq4KbaQGS++vrRk0HVL18THLD6Tdi8NvuwJwkjk0DFzkApDnGsyWmPcIo
	A7ZprwI0BEkHHXFGSbMHypJnGF3UbUDwCxy5yku228xAubwsojdq6laFsQEI4LU84P4B+Q2sjuS
	CSKFFfzsgwmgr3kEgKL/yvAVprIAvMMEXp4fANuupAxRwJOrCLfPrnnkhGkxFXAoU4wuvwaKVGt
	S4bQw8kF8tg9klkLDJuNtrUMWMH00FlJ3JhqDQeLX8ijcNTPOMgj5ePZ27eb0Meqdjnsl1UIL7/
	vFVu6Bk+EPgrs92JZwO7CCusxg=
X-Received: by 2002:a05:6830:2105:b0:806:9a8d:4b9b with SMTP id 46e09a7af769-82acf49f6a5mr7338564a34.15.1791490237678;
        Thu, 08 Oct 2026 13:10:37 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:220:4650:f501:3b3:565b:2d79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82fc7cc90aasm601054a34.4.2026.10.08.13.10.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Oct 2026 13:10:37 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [RFC] virtio-net: AF_XDP zero-copy TX checksum offload
From: Azadeh Aftahi <aftahi334@gmail.com>
In-Reply-To: <1791423335.8486545-2-xuanzhuo@linux.alibaba.com>
Date: Thu, 8 Oct 2026 15:10:26 -0500
Cc: magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com,
 sdf@fomichev.me,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 mst@redhat.com,
 jasowangio@gmail.com,
 eperezma@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5FA6FB0F-51BB-407C-BD2B-A13FC2FC94BF@gmail.com>
References: <9DB6FE89-98AB-47CF-9B57-5F47FBB6DAE8@gmail.com>
 <1791423335.8486545-2-xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)

Hi Xuan,

Thank you for the response and encouragement.
I'll proceed with the single-buffer AF_XDP zero-copy TX checksum offload =
work and share an RFC patch for review once the initial implementation =
and tests are ready.

Thanks,
Azadeh

> On Oct 7, 2026, at 8:35=E2=80=AFPM, Xuan Zhuo =
<xuanzhuo@linux.alibaba.com> wrote:
>=20
> On Mon, 5 Oct 2026 17:28:35 -0500, Azadeh Aftahi <aftahi334@gmail.com> =
wrote:
>> Hi all,
>>=20
>> I'm planning to work on single-buffer AF_XDP zero-copy TX checksum =
offload for virtio-net.
>>=20
>> Current net-next's virtnet_xsk_xmit_one() does not consume XSK TX =
checksum metadata and uses the shared zeroed virtio header.
>>=20
>> I found Xuan's 2021 proposal anticipating separate headers for =
checksum support, and the merged 2024 zero-copy TX series, but I =
couldn't find a checksum-specific follow-up implementation.
>>=20
>> The proposed scope is to map the existing XSK checksum metadata API =
to VIRTIO_NET_F_CSUM, using a DMA-safe per-packet virtio header whose =
lifetime extends until TX completion, with corresponding completion, =
reset, and unbind cleanup.
>>=20
>> I would keep the initial scope limited to single-buffer TX: no =
multi-buffer RX, timestamps, launch time, or GSO.
>>=20
>> I'd also add checksum and header-lifetime coverage using the existing =
XSK selftest framework with QEMU/TAP.
>>=20
>> Is anyone already working on this? If not, does this scope and =
per-packet-header approach sound reasonable for a follow-up patch?
>=20
> It seems no one has taken this work forward yet; I would welcome it if =
you were
> to do so.
>=20
> Thanks.
>=20
>=20
>>=20
>> Thanks,
>> Azadeh


