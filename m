Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795718562;
	b=32h1vPuJInNsvg+L8BOd0fOKy3X9ixGjrio7wKDnRcb0y4YvSCdGW1qVDwAM3+Ly6fcB
	 b0GhUzHyn5/xNT5ASTRX78NDmiFwzEtXjcgpPX2JY5QzEJsNI0HRkEA0hLut6g7eGAbMj
	 1frnfsHQcgcIJ7TtM6U2+pVLsc2Bn9feaqpuEuCcNKTTcGSM1jL6OKApDA62qjAriiG+q
	 WuGmPzPboC+WzWMHrkvj0W4MzpQpzyzW0CAIoMy325sLk36E+leYTyajECr0jRWfElpWm
	 0KR0wKzdCw/gCnV3qw/EW6itD4UMe8zbkfgxShMa7MDFuoG1h9ElUvPYsprNcWz02vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795718562;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
	b=NbCScExZPlcynKN0R/sonhkph9pVEdL+RRh3yt//qCSZ+T+sh1/cE7QAoF19JHpnjaGe
	 AK/bQsdOuE+KHz8K1i9NLTtRJWMjiP/znbQsFtMvZlLb/UAoDJXk59Nt3AgW/11kQqsmN
	 +pXs9UQwS7MW4bzUthdf6AoZ1/Yx6h+Ik4rTPfbXOxuOXHS6gguJjgP7rluY0uW/S7nrA
	 J2Ve2YOEo89HbZme/D4fprIp1mReWcY5OCGR1dLXUk7gbsd+PJD0ea11a0Su7aFVQm8G0
	 T3catIMz5VsvHly0s4DdRjl1lyEMlLt6fuLvVgpJMsk70s/oIIyCaRp6q1cWdi98pDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dSJV2yS5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AfZRd78T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE12606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 18:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCE12606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dSJV2yS5;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AfZRd78T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795718561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
	b=dSJV2yS5i5n4Y0qa8QpYgIlvjQkV6ztVeP14NykEmG4e8ZTbbOguUnFGnuZkgM1hfvob6r
	JsVpE2hnbjdJj2tNxhz/Zlwdqw/UfaoJiNIXP67HDDrgplpsiOxKUG+XGfh9aXwyPW8bpA
	cl83VPqy12HNsmZ2ziLdHqi20GJFVHs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-ene5ENWlNv-Rv3oQVjL6eg-1; Thu, 26 Nov 2026 18:42:39 +0000
X-MC-Unique: ene5ENWlNv-Rv3oQVjL6eg-1
X-Mimecast-MFC-AGG-ID: ene5ENWlNv-Rv3oQVjL6eg_1795718558
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-92111028a03so129992866d6.0
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 10:42:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795718558; cv=none;
        d=google.com; s=arc-20260327;
        b=fhVdPtNG5IrSeOWrMr5tUlPYJaB5OcQpSQvy66F8VgLbQMedxlBE28G5bjrFLrY/Yz
         DSQntCEbx7mkNsEYk2xj2ZZxvx2kBR6Ef2x/PLFTdXA192yYk0d7YhYww8ZDdZZfLiTE
         1GyRJGXijbTeX9Q3J8zRVPMJxO634dKFZI0FQNYpw2uGdnOEgGeHR05UKtEa5Tx4tZMg
         3OxXXw6EwBw4MeMbkz/FQIKIHiekpOyQle5whEOLLn0BfOa4LoFNIT62vGdGBeSrCiS7
         XblSdB2MJH2UoPtitmbyF/mp9UBh2wFb+cFcM37m0nKWzG5+U8Rz4jQkrhV8UR6WZYcz
         gbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
        fh=4b0LTXI16hujnGJqGXsRW9lN5cHYsh0fTw0UbScGn6I=;
        b=YY0duq70uwKprMxLOUtsqZSusgZHxH2F4IVoEEW0FwUFvCb5du6jjYDayLOiY2BLaa
         sM5x4vtiyGKWN3a6aFhtNYiNVfBaVeH+ph6688yyzYccJhewW1Y9qYQS+niY/QjacRnB
         0omy6veoDg88vMS2hDT9PzHjYqoHa/22aSSvpRjrh7vOYCBRKB9kpO4/aVeZ1A8oCzsh
         7lwrz12IUtVySNDN5Sw5qkKdj6ONBNlUxNHLODkORuL2ceEKarmDUNQUT340VtD117ei
         pft+VHui98nAyelblQUtpj8IpyRkywLs83J7rGtRG/5H6Cn/trtOuddk0zmuNH1Je3/5
         k2mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795718558; x=1796323358; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
        b=AfZRd78Tl2My6cFNYn6J2IoXlWU7jd9dGbwrI6sPcEv8IbdB7fLO2XDTbfQrF+Io//
         ixsvT2itMWfRas0wyep77elrun0b0HGJrXml5mtbVm6K8dyKkh0KXNx0lrSGsPUkPCd+
         htlBpxymRJe/MctD8/s3oBLQrenF1llfpvNVhQu32t7LIWWg1Bh7H8nsKdn3e7FAE3vz
         mQxf/6gLyv6dziabFgdbxxM1bskyM7oKpN9JDuuuJ0aXwEDBLVIA3qoPxkSditthi7C9
         qBl0dW/paw/ir3LbJm8JTGe5BmEL00jx/ma8TFxiJ/0OxfY1hFMGLr2/eSwDP5uNRg0l
         WIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795718558; x=1796323358;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbAhtOscc0IR1lviJrjyLzdj52UktyrxEKNHMTQqXwA=;
        b=TzIAMNyCkyYeRdoEu6d4WHJv1jOA8dXmUiDyaoeUxHQTjZGY2JqbL56Os4/9w8RmYR
         xLea0uBZeQTQ54IGWqj/yPl/D1SW3fQBgiHWzMfXMQD+jfpnhF0SvdO8okED9oQlHxAj
         jikDZK+fQDN7Bb5HdWhUofC5fKhT8FlmL8Jd5/mUjaigSdb6sKDUSemCtmJk6+vwrXHn
         xZoDridAmU27/JxqvQXziNjG+3kqDAQ5OpMPVdpk2RVjOoDu/XmDkVjOntTTvg9kcIwB
         jXkPfUmilyyXpYCp9ORhkV79T6fmt/wKL7BT/kbFFtwL/2R9UKl6jgeiqzWH4rUcRA4/
         kLew==
X-Forwarded-Encrypted: i=1; AL+hErEBX43iv3MV3nKWpq2N/RNrxcO/ZaThf6F3zeNajeQhuFhoTkiuqCrBbuhMSruANSywQTg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kmfEq72iRCQ8o6JCkvQeN0xANryByRv9CpkQRnA9Sf9anb6kn
	5F5amlu6s8yKncjPV71yzP4nT/DRs6q4vVEBGgAOWa2REmx1XCtGSSvIoAMRf4RI501peekhJkX
	PzbDzDWGX1qYtgRhvfXcuXBnv2LYl3nn2lITX4aS7WtT+m9qDLblIeLfBtQ0zuxn1DF6DhWhokA
	vrK/AthJNmjmZAvbZ1TwzJvt4j6Llr
X-Gm-Gg: AZFdTZcGrCStkkg78StcF3bjCaqyaIgxEo0ARJ2elxm1L0+tTTtBM0qTFk42KKqbtEe
	uXwM7/czjM5JLnXMfdixzjPsHv0vtvHqw8VVz4AO7rNjKLx8SVWuFtnfMKhTJ6RtqcEjPF2XIZs
	9UA4xa/MVNBqsPBdeoVTJp0etnRJAg5RdCDkkrhAKV3olvUvVvFx4PoXc=
X-Received: by 2002:a05:6214:5701:b0:921:7c1a:5953 with SMTP id 6a1803df08f44-9217c1a5a29mr99541996d6.14.1795718558249;
        Thu, 26 Nov 2026 10:42:38 -0800 (PST)
X-Received: by 2002:a05:6214:5701:b0:921:7c1a:5953 with SMTP id
 6a1803df08f44-9217c1a5a29mr99541386d6.14.1795718557797; Thu, 26 Nov 2026
 10:42:37 -0800 (PST)
Received: from 821463759402 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Nov 2026 10:42:36 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <awhAaTuR375RpyAE@sgarzare-redhat>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com> <awhAaTuR375RpyAE@sgarzare-redhat>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 26 Nov 2026 10:42:36 -0800
X-Gm-Features: Aa3M54odw2FRTdRy2uflU_aL9ZEV5X35-hMgLihiDc4DudGmLOU2wiibEdItlhY
Message-ID: <CAAiTLFXT_Dqs8sUY+dL7KhXL=-QYudikb9kVFFRvGv9Ri7y7ow@mail.gmail.com>
Subject: Re: [PATCH RFC v4 0/8] vsock: add datagram support to virtio and vhost
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, Alexei Starovoitov <ast@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Sashiko AI bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Stefano Garzarella <sgarzare@redhat.com> writes:

> On Tue, Nov 24, 2026 at 01:20:18PM +0100, Sergio Lopez wrote:
>>This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
>>the existing AF_VSOCK API. It is intended for guest and host services
>>that exchange independent requests, responses, or events and need message
>>boundaries and sender addresses without a stream connection or application
>>framing.
>
> Thanks for restarting this work, I have finally found the time to took a
> quick look, sorry for the delay.
>
> Reading the cover letter, it is not clear to me the changes we are doing
> to the core and VMCI that was already supporting DGRAM. I'd like to
> understand better how the backward compatibility is handled and how VMCI
> behavior is preserved. Also reading commits, most of them just contains
> a description of what the code is doing, but they lack the reasons
> behind the changes (i.e. the why).
>
> Overall it seems the right direction, but I have some open questions
> (some of them discussed with Bobby, Stefan, and I at KVM Forum some
> weeks ago):
> - Can the virtio flow control be affected by a flood of dgrams ?
>    See https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-5720001
>    and virtio_vsock_pkt_info.reply / virtio_vsock_skb_reply(skb)
>    handling.
> - Did you test virtio transports when VMCI transport is also loaded?
>    That one is automatically loaded (for historical reasons) first time
>    AF_VSOCK socket is created, if af_vsock.ko is not loaded. So could be
>    a common scenario.
> - Any limitation of the current implementation that we will need to
>    fix/implement in next steps?
> - Any performance number?
>
>
> About patches, I started to review, but I hit a wall with patch 6. It's
> too big and really hard to review/maintain. Please split it (e.g. the
> refactoring for vsock_assign_transport can be moved out, etc.). Also
> there are too many if() with conditions duplicated and few comments on
> those conditions, for example:
>

I agree. I focused too much on quickly addressing Sashiko's feedback and
things went out of hand. I'll rework the series with a focus on
bisectability and readability.

Thanks for the review, Stefano!
Sergio.

