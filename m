Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B350A3BBFC7
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021244; cv=none; b=Shtv7Qm+i9U2mz8mvU1n0q+GZy5Qd5ZWeDjd+BYfACkTPs+zxtcJwEmq9RXRnBwLi7MQGsW61/1e8Uo20R3Gql2TTgLN78CAV2rekAIQCnqzx/f33u3vcUtKbAw4st9eQ4NCnBR4cXRsaKaP24Teeh3cU0r8SZ2iWv7EcMOFNhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021244; c=relaxed/simple;
	bh=PuFx0zWXcplwcO/kwwbec+csZfwCfv3PjuRMiBzgrK4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XZJ8/YTJ0zgZndL083EDVXNgh5EtiiAltQWWOykX+r1oxwsR7LdhFTfEpnyFfV9k7xHGheVcn50lvRV1Oj3nIOjA2rMgEyOEay6pJn6nxOB5cCat7cfuzA8783ZCWxUmBtNXD/7znuBcxEi0znDBgPAXXhrGPjeJWvfhMBi52fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aywX4vr+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtdP3DZb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aywX4vr+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtdP3DZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791021241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pj3fnkRnguG1XzZ2CAsEmH/UIzLjDfjSPrnu5Kpy4iA=;
	b=aywX4vr+jaPHR9wHwKFtCLHdgwxLpsZrxWyQxnbQRHpkoiFnVLBMmNWMxLmPezj7Q4CH7Z
	OvNBHUpaaAKmhjP2iV9PYgEoWK9KtpxsnAHpT7sSKof4aP2Q9G0bbp9SMO/puxbzOEhjBO
	Fo8YP+Pa0zF/4Y4o2cn/Y92OJeM2GH0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-4uuwsmSDNSW21JdgUorGPg-1; Sat, 03 Oct 2026 05:54:00 -0400
X-MC-Unique: 4uuwsmSDNSW21JdgUorGPg-1
X-Mimecast-MFC-AGG-ID: 4uuwsmSDNSW21JdgUorGPg_1791021239
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a0023f2b60so3622135e9.2
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 02:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791021239; x=1791626039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pj3fnkRnguG1XzZ2CAsEmH/UIzLjDfjSPrnu5Kpy4iA=;
        b=HtdP3DZbWeCreZmZN7fUAmzif1TTLCD2K0/R7NvgKggJcSCHrJjMylmT6ue7xwE40s
         TbnGviD9DHMNXAibM8qXYdnQxdrAY8uOBon9OCwrwCaspyiWmjFZGfIvLMV5LXk24/TD
         LlnnAz69e1QxX9IbrWZQmVsS6glGm5tJT2gEzXo+e/LwjCmgyWMniTkEkfY3VAioqeei
         8DAcnArkz9HlxbOqOrgNGpI1FDkIe66wHiOgrvU4mrqrRlMKiKrjaLH4UGcJ7lnVGQo5
         YIlqEh0LL/gIzFcuCxeVU9o3KC5Sdr296uouQEm3Y6GdOKNBELMfqTm+XHGskK9Eo6A4
         hBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021239; x=1791626039;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pj3fnkRnguG1XzZ2CAsEmH/UIzLjDfjSPrnu5Kpy4iA=;
        b=QcxbURsb/WKbRoQpAKYoTCEjvpcOD0khg/AbbMr0jZIVjNwxcYE8VJDPIk3lF/Wj5Q
         tlB0kcrzI6jE7DwxxezhsqVTy7pRUIlkmpUyWE/fQ5BisJVwxx+jCm64wQS5SgaaR7lV
         ipWjqVcttdq4C7bKOhMK+jSNav03iyPoSa2Fw2rCP08bbfedIQxv2QOb3IljkQbujdQJ
         7bIwEIoxd5qJnLhUkOmi5WM8qmoIOH5KSGbK+6A9/biEQaiDSO8hsCtHB4v0tp9JFyud
         eonbkh9aXIxKr3kcs0s9LmIwguf/w6ZC0fSBNmjRv1y7IborXba018CN9tms0sw+J9kt
         Htew==
X-Forwarded-Encrypted: i=1; AKwUvBx7PJ0GjyViZMDAS1Saz0Ji6uQPwK2YYYLoHfr9//8i+1DFHep8pMX0NP9vyI/G58Irxnk=@vger.kernel.org
X-Gm-Message-State: AFuF++kqXvei4xAJX3n6Hql6mfWmzpIYjZPMRvFsTMmRQM/7MYu2qI5Z
	Xh5Dsz0QenVWMS4as7rvhBpg+L6TNJseczEc8p9C1RR2XDxe+q30s71XqM0MTta+g2Ne+eWSUha
	2558ZrBH15UjQi1oz+UPgxjYqZF1CdtSzeXNbTGMqqHss0R0l7Eiv5Q==
X-Gm-Gg: AYBFou3oZWqh2wDZ68uqAu3XreL8Y/p5kRTks0uqneI1vCOt9o2wRq4XSXg/B+yD20t
	dtJi3vzB2judStabun0ESviizWG0xYQAQk4d08Mj4imgwlCn6cjdnEbt8xUXZRkhoeSYImbEqoN
	4EO2QYkIP0IH0XpdBWlwZd4JJchZRqnRrjdvNZEtbb3fRqX3ZS0AX7j9bYYd4LnVCrz3m6ZaqXc
	C8+0W4woJrFle3/Tzk8vbpEbe2xojOQrEmqkFz1Balp/tHWiKZ0nP78/Cq2p7gkOiQgXyGU1UXM
	kbRG7Tia0Yq8VaKQ08/3gZeciXN0WVsjAPfkQg2axUhmPN4kKNaUilnOwQQh4FycgyQ+exbOxmr
	HhG1Uu7HrtBONoSgGPAdzXVtJAJZbpRdpZH6QvfM=
X-Received: by 2002:a05:600c:3c98:b0:4a0:37d:9e21 with SMTP id 5b1f17b1804b1-4a168101d2dmr29368925e9.29.1791021239046;
        Sat, 03 Oct 2026 02:53:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3c98:b0:4a0:37d:9e21 with SMTP id 5b1f17b1804b1-4a168101d2dmr29368635e9.29.1791021238635;
        Sat, 03 Oct 2026 02:53:58 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104d64sm10844602f8f.29.2026.10.03.02.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 02:53:57 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:53:56 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@osuosl.org, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_02/10=5D_ice=3A_fix_IRQ_fr?=
 =?US-ASCII?Q?eeing_in_ice=5Fvsi=5Freq=5Firq=5Fmsix=28=29_error_path?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-3-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com> <20261002130752.2597259-3-poros@redhat.com>
Message-ID: <5E5BE0F3-4AB6-4DCB-A730-511D626B9189@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 2, 2026 3:07:44 PM GMT+02:00, Petr Oros <poros@redhat=2Ecom> wro=
te:
>The vectors are requested with the q_vector as dev_id, but the error
>path frees them with &vsi->q_vectors[vector], which is the address of
>the array slot=2E devm_free_irq() finds no matching devres entry, warns
>and leaves the IRQ requested=2E The unwind also tries to free vectors tha=
t
>the request loop skipped because they have no rings=2E
>
>Forcing request_irq to fail on the fourth vector during ndo_open gives:
>
>  ice 0000:04:00=2E2 enp4s0f2np2: MSIX request_irq failed, error: -16
>  WARNING: kernel/irq/devres=2Ec:191 at devm_free_irq+0x30/0x40
>  WARNING: kernel/irq/devres=2Ec:191 at devm_free_irq+0x30/0x40
>  WARNING: kernel/irq/devres=2Ec:191 at devm_free_irq+0x30/0x40
>
>and the three IRQs stay registered in /proc/interrupts while the
>interface is down=2E
>
>Pass the q_vector as dev_id and skip the vectors without rings, which
>the request loop never requested=2E
>
>i40e fixed the same mistake in commit 915470e1b44e ("i40e: fix IRQ
>freeing in i40e_vsi_request_irq_msix error path")=2E
>
>Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat=2Ecom>
>---
> drivers/net/ethernet/intel/ice/ice_main=2Ec | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_main=2Ec b/drivers/net/et=
hernet/intel/ice/ice_main=2Ec
>index f2121e79fca993=2E=2Ed246cde36ae726 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main=2Ec
>+++ b/drivers/net/ethernet/intel/ice/ice_main=2Ec
>@@ -2582,8 +2582,12 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vs=
i, char *basename)
>=20
> free_q_irqs:
> 	while (vector--) {
>-		irq_num =3D vsi->q_vectors[vector]->irq=2Evirq;
>-		devm_free_irq(dev, irq_num, &vsi->q_vectors[vector]);
>+		struct ice_q_vector *q_vector =3D vsi->q_vectors[vector];
>+
>+		if (!q_vector->tx=2Etx_ring && !q_vector->rx=2Erx_ring)
>+			continue;
>+
>+		devm_free_irq(dev, q_vector->irq=2Evirq, q_vector);
> 	}
> 	return err;
> }

Reviewed-by: Ivan Vecera <ivecera@redhat=2Ecom>

