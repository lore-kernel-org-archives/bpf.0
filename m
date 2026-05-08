Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB643F54C4
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252223; cv=none; b=el7FaYeDcNsj6C9LLqCQrUuRQOIiZvtpDTRsPax28cXffsXOm5BV8576tpPQ9+KBK7dRUCkjlcV7qjicQkOAPq/1w/h1MlBwjC5ShqqrZcGypuUp6oYkrna43pMY2enPXr6x3bcsskfj3wlGQ6OKtuZdc9SaTmMvLtDNBxy7s1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252223; c=relaxed/simple;
	bh=4/aVJnWaXKkXi45aVG/ghAkKHKmtNlgv64ubRDm3pNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVwo+qVNDJFXxVRpX8GBY4GQ8/zuAKsJSQq9D3OBkvYsWm0EKUmZ+ht3HCZVtikxIF57ug1WBFt0XJm8M8i1CFFaeYm6cpE2RbVJF4vJqb55+sP29oXGPmiUe4bcyof+qayjFDlH/hglvrZrNpNb/59KtMTuJ03AATLxI2p+mfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3bMKqn/; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3bMKqn/"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-83537a80ab6so1351124b3a.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 07:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252222; x=1778857022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MKeh4P5RRX9HdRzyfTHqYV6PxblA4dDzAyEahLUA+Ik=;
        b=A3bMKqn/Gk8Irboq+VjkYR/RT3AMkP+uqrEWN1i6QzdfkjeKQeFGPEHxQOcNgVVCfb
         3BHfxwMeebOqbTkfNMbfaMt3dOOPBVmScJUowDz5LrgnEGB8ZWSB0vIJPKwqzkUk+Xek
         bOrlfoBKysN3MkFH5GCsFBGcnSxFY1DeVT+6QWI8MmY4PAhaWQRyJY1F8lIguVJv1BYn
         iwUUi2jv4WoQmeH8e5HLfsPdIEzbhIzTBE+wQrRzt+RT4vM3myf2jEOZSsZ7+pkrET1x
         8aa0PJk9TPozZc9utIvBCoaExaFcJieMoMI/sY4H1CgAacVTRrL9XW0vdmBUeAfVOzco
         /pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252222; x=1778857022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKeh4P5RRX9HdRzyfTHqYV6PxblA4dDzAyEahLUA+Ik=;
        b=KmKAqaqBmDHAJ9KU6ucz/ikzuJDaPMXf9lEwfC2TxD+WKyBYwnQhuFRbZSsxG9V0c7
         /DFW0FKVWu95PbOiO5FhDTep0r9xu5RdtOhfjQvoQvzID7BJjHsUTVz5gjreJGtdl2Ke
         kVP7y+BNyN72x6Sl6LCzB1y/S3VOiidbz+YPSXenEH7pz4wDwBsE9XrV4qKXNatdGBHg
         rikrWtDAszhRdGasFuyk+w2/S2bdAmcoE6zcwmSz1FHxMt+gZbOXmkFCSiqxvUK2Na57
         DznPRWVA/X5fXl23l1cqTk7C+KU/g21iaw3KwhS2dhVrUmhyPpPjtE7WCswf1gdT96Xy
         3FKA==
X-Forwarded-Encrypted: i=1; AFNElJ+Ppjy0CqgR8cEyADOjfN3JNTEXoRGtDEuBWOil0Wkv6ROA5OKezdIbZNKs5QXrfrww5vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkzuRlKSwoiyaG4moNiudq/PmOvJqPuumvbqNtiby3Q3iU+Suv
	RQIaHHX9bLuom9rSwriNKEvLy3ybrBdce3WKFzXtsqBO52cK6ibo/3R0
X-Gm-Gg: Acq92OEMEmk/r7WM0leEki1lAAjS46Y5J2E5Hc0PvNXPhi893Jp1QlLNdDgaBWfa870
	lwO6MgVaKRj9octVKOVX+jzZgX6YflXWnWNrEI2AXyc9Fw7+ulA2341cXq4FqKJr2TdaTuRO32G
	txGNkDc5JQzhF7ksYAduGTdu47ef3sgcLJips6YG1plpDst3p1p7e8BNl9SxQTvh8i1E6GhStXV
	8lDi3gFyANzKdieJ5/OFEKMEtPJyngxOCFNuwn86M7C9EjpiUuQlsFbULPpU/K3W5+aYI+tduNI
	z1plLDHk8ezLTGxt76vtb0MegRpZ7Cx6OTKxm19CwWfGhC97ulmYt1mC38/IX8WvqkiYR4DafZK
	3j+O6HD/RZcI1wMO5OItDZ8Ocy7Gb0YPOTNEhfzSEW6pvuhwOQCHbBx622kErQVE80lxMqv/3XC
	booVVGyWfrYNaToEl3
X-Received: by 2002:a05:6a00:4195:b0:824:374a:1407 with SMTP id d2e1a72fcca58-83a5c4bd711mr13683272b3a.16.1778252221575;
        Fri, 08 May 2026 07:57:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839659498f1sm16492392b3a.17.2026.05.08.07.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:57:01 -0700 (PDT)
Date: Fri, 8 May 2026 07:57:00 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 2/8] net: netkit: declare NETMEM_TX_NO_DMA
 mode
Message-ID: <af35tYOAr5Xymm20@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-2-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-tcp-dm-netkit-v3-2-52821445867c@meta.com>

On 05/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Some virtual devices like netkit (or ifb) never DMA and never touch frag
> contents, they just forward the skb to another device. They are unable
> to forward unreadable skbs, however, because they fail to pass TX
> validation checks on dev->netmem_tx. The existing two-state
> NETMEM_TX_NONE / NETMEM_TX_DMA doesn't give the TX validator enough
> information to differentiate devices that will attempt DMA on the
> unreadable skb from those that will simply route it untouched.
> 
> Add a third mode to the enum so drivers can indicate 1) if they have
> netmem TX support, and 2) if they do, whether they are DMA-capable:
> 
> NETMEM_TX_NO_DMA - pass-through, device never DMAs
> 
> Widen dev->netmem_tx from a 1-bit field to 2 bits to fit the new value,
> and declare netkit as NETMEM_TX_NO_DMA. Devmem TX support over these
> devices comes in a follow-up patch.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
