Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D48035E95C
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021341; cv=none; b=L5902exqDkpQ1IJBsuP20oi2WzXpjNX9wZiRe+9skshpYEhZDg7IJRFEsMZCm25VQFC6aSwj3FyBo9fqcCxjcFbaV7qcAm3Jm9zvMUmd/rSN7J8c36K8GPpHtDxZlsL/65OHH2+Lu6nIKyBKlA9lxn+U+fzE8e9L2E8YgmzP3GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021341; c=relaxed/simple;
	bh=psEp9L/HNNP6scWdonG1BJc8Csv1F1ySlCLU51G6drk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MBYzOZFJjcXH/7vbpcCefYS07Hy28PBxHKOxiWxp1EIZWQQn09aoJP/QGkJ4X8g3+qlybykDoWSwGo6TeopvjNWJsxYrMUdC3Cej2valCFUdncw8mgHpMl3dIKumlNpJHA7la/bOMt9Q2XNLZ54lWjR6qPTL8FB+2Xjm9YWbmco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BCAjGNpO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+iOhPt/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCAjGNpO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+iOhPt/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791021339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9oKQ4IhLDD9wBALXASu8n+QwFqOU76snzOYZ8jECb0=;
	b=BCAjGNpOZy7kXCp91rwDBgx7qXhtHJrmZ3QmICruyvHto3SD7ASZaq6zziBNajmBDu/LbA
	f/l5WNZX9kd1f8g+W57Uuo/KCu9UGehE2TQFetT2IpN8V6azp2cy3LZirH4GPUblWwljsT
	2H16jeGFJsGyVjXMyetSM1VOSeGYYDE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-O62h-6DJMHqKtaDDwDEgLQ-1; Sat, 03 Oct 2026 05:55:37 -0400
X-MC-Unique: O62h-6DJMHqKtaDDwDEgLQ-1
X-Mimecast-MFC-AGG-ID: O62h-6DJMHqKtaDDwDEgLQ_1791021336
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a166a9ea21so3913245e9.2
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791021336; x=1791626136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=R9oKQ4IhLDD9wBALXASu8n+QwFqOU76snzOYZ8jECb0=;
        b=V+iOhPt/kwunhdVf2u00UWlc2pTBjOJw1lsEbraZ/KaGQU7Ep71cCQu9zkvdpvjdhu
         uFRwrtAPRwOzIvqGRE5iRXz2KZjL4uCx/weNXDCtQpscU1wZ8rUqyMUL4FW+76+b/SBc
         6lfPA/pD5VGSbRNy1JjJTMvNVpBP6cinw5PMOAc0sai5Ug34bhC9nJTyuzk3P6NklNdp
         eewBVUm5uO/l/DcyjUiTQy9ENVnWqlTZSZ/TRcZaxhJz5xIjCKRhB2e9F3lF1X5XR7om
         OEaY7JfSMEAt1HYk1jBwNnNGkRsQoYr7OYVNPPfbyYabWzf9tjHpYaebG1ZijGOMeAk2
         RJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021336; x=1791626136;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9oKQ4IhLDD9wBALXASu8n+QwFqOU76snzOYZ8jECb0=;
        b=KvX8Ng6Gjn7RrcMZoL2DpCS5AoQYeIuVUL8T+XRs1TQeq1ewyABog4iBzX3Onucv90
         FQYy/fyKkLYLu8sXgE9F7ouSKVT1vJSf2ysod3Ke+x2ygSaJpl+WNz1gX4OO5VR3asn8
         dRHLbXIwXlM2Pfh31aNasDLzjjRdqTmCNGzJg63rFeZJFaY0ktDzok9R0je1HM2zgBYP
         pr6BCZYVa4NMqBy4zVvJtlPxSkpOR6lZ/3EA1ugAEvePtz61OdGu2O7YAo9LWqTY0Am8
         h1vJY6bPmXJpcuTYdMtE16YF8v+h6x3Mn0222vqQZAArzwAnYUk711faSCTzxHlb374K
         Ycow==
X-Forwarded-Encrypted: i=1; AKwUvBy5ysUaanpUwIfg3QZlYiOh+uUaQLQ7mhQRyYumwOHgexszr3ASUFQ4abDmjaiiN6yQrA0=@vger.kernel.org
X-Gm-Message-State: AFuF++mqPSeuNQ0jdhrQ077f3KMu2HkFitovbxNxdvm5eo+bL6IEVdGu
	EN9f8zYz1Akc5pftNq1TEKaZGs384Ncd/EC4KAMtiX2sVhgMK+QmeaaLBgt4M02yOnTgV6livij
	ozwwoOddjgmFRColBLOKzLRDG3rTCHfVToBpHvcpV45Uq2ISZqdKi/w==
X-Gm-Gg: AYBFou1b+aT41zjkC6rLE2+0frAf5y0pfiY2BOMa3yiIDaijEL351O2Yme/Mft9SJAP
	J7BOiK5fGC8RiKpEgCD64e+9uC2agJUSiR+BgwmLrlSWpzbHJji+gP4ciz8dst9N+vp2PADOjwC
	qVd0vbxKpVIGMqkfsXSHc/sg7R/5FBbjcTl+7E3JkTPD3tW5pWM4PZREcZN86sQXprX6Qeufg1w
	I1kvb+T6vw8cZoLMiTmgtdQPh4gis4GvOZEm0SjY4np4tOSy7K8JUsUAu5TfyKarQCMJvYYugw5
	HV7ttNUr52o6kkGBVImxUD6reFOdUHANyJFJW2ONfWE5U90J8R/DuLJDngYp+FTd1zpRv0RfJ1A
	6T+EFctLFqo8pJcZurFPpcs64/mJtyi8MvdsNeiE=
X-Received: by 2002:a05:600c:8b2f:b0:4a0:e45:e8d6 with SMTP id 5b1f17b1804b1-4a027559b0emr79402405e9.13.1791021336264;
        Sat, 03 Oct 2026 02:55:36 -0700 (PDT)
X-Received: by 2002:a05:600c:8b2f:b0:4a0:e45:e8d6 with SMTP id 5b1f17b1804b1-4a027559b0emr79402045e9.13.1791021335818;
        Sat, 03 Oct 2026 02:55:35 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027735be1sm217904535e9.11.2026.10.03.02.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 02:55:35 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:55:33 +0200
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_06/10=5D_ice=3A_keep_adding?=
 =?US-ASCII?Q?_MAC_filters_after_one_that_already_exists?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-7-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com> <20261002130752.2597259-7-poros@redhat.com>
Message-ID: <C4418E3E-4192-4627-8614-E35AB517DA4A@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 2, 2026 3:07:48 PM GMT+02:00, Petr Oros <poros@redhat=2Ecom> wro=
te:
>ice_add_mac() returns as soon as one entry of the list fails, including
>-EEXIST for a filter that is already programmed for the VSI=2E The rest o=
f
>the list is never added=2E ice_vsi_sync_fltr() treats -EEXIST as success,
>so the skipped addresses are considered synced and their traffic is
>dropped until they are removed and added again=2E
>
>In a test that adds 50 multicast addresses to a port in a burst with
>the port MAC address in the middle of it, 19 of them were left without
>a filter=2E
>
>Continue with the next entry on -EEXIST and report it once the whole
>list has been processed=2E Other errors still stop the loop=2E
>
>There is no i40e counterpart of this fix, i40e keeps its MAC filters in
>a hash with a state per filter and syncs them differently=2E It was found
>while building a reproducer for the MAC filter overflow handling that
>i40e fixed in commit e58872398684 ("i40e: fix disabling overflow
>promiscuous mode") and commit 7363115efb04 ("i40e: do not force filter
>failure in overflow promiscuous")=2E
>
>Commit bbb968e8b34c ("ice: Fix issues updating VSI MAC filters") dealt
>with the same problem for the VF MAC filter requests, which are now
>added one by one with -EEXIST tolerated, but left ice_add_mac() and the
>PF filter sync as they were=2E
>
>Fixes: 89f3e4a5b762 ("ice: Do not bail out when filter already exists")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat=2Ecom>
>---
> drivers/net/ethernet/intel/ice/ice_switch=2Ec | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_switch=2Ec b/drivers/net/=
ethernet/intel/ice/ice_switch=2Ec
>index 2ee5cb6ffdab1f=2E=2E239d4d9633baa6 100644
>--- a/drivers/net/ethernet/intel/ice/ice_switch=2Ec
>+++ b/drivers/net/ethernet/intel/ice/ice_switch=2Ec
>@@ -3659,7 +3659,9 @@ int ice_add_mac(struct ice_hw *hw, struct list_head=
 *m_list)
>=20
> 		m_list_itr->status =3D ice_add_rule_internal(hw, ICE_SW_LKUP_MAC,
> 							   m_list_itr);
>-		if (m_list_itr->status)
>+		if (m_list_itr->status =3D=3D -EEXIST)
>+			status =3D -EEXIST;
>+		else if (m_list_itr->status)
> 			return m_list_itr->status;
> 	}
>=20

Reviewed-by: Ivan Vecera <ivecera@redhat=2Ecom>

