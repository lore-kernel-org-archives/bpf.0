Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1904A2A78
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529852; cv=none; b=OdJ5PIU0/CeL3KFN0ywoBirAm2l07cxGgmHY++r7chPep211HRsKQie2t9eLxgE2/QSYoINaFMGj7GpFHdXwqrfCVqwpUEJu7LGjGYfqRC2aQkTNh6ve16d9dQ8kAmnfrgikD+jtkYBCxN7IWEU/S7TN5FS4vlTMXEb8uBOUDoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529852; c=relaxed/simple;
	bh=Z8hNnyHSVmt549ei10OsDc7fux/5aK6L6Q+U/yY2ZJw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ngEeiE5D92cTTfmRz7+H9Uj+pDBbtwrH2TdJcOIZTdsRf5JLKwIEe01A02NZrsKx01Hrcp8qiTJ/CCo4tyjjPBsx2RT5ByYpkFU83uU5pFsQU6miwTrsw99v2kHpNWO91/HOrZinYZAT+DbjvobJ2aBOXs2BHj32tmnySdEE1wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQFelx79; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQFelx79"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52eaeddc837so10025131cf.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 06:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788529849; x=1789134649; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RloxBmq1OFFdMW2QFzzJPyBKTHQtM11rCubg4Pmtdw0=;
        b=TQFelx79SVUXXk6lPuhJkCpNgaMkUrKUBvxqQfxohmyi9xBVmosK/MQjKHh6cJDyOc
         osRB1ymPJcn7Cv+hbYnmld0znVmwVN20tnZZas/tFaar2aXm2/nV++oBqfK1VEkvVwvk
         FQ2FAmermUrsgjpeDDBOCnSofvfnRQ33piuv0X8JVt5fzJo5EVy7DxWUHVwAHmFbLDkd
         QJ9R9g6p3baFaj4+zUR1I2OWxDOVzISlhO3wADzQkzwf9PJ2CejpVpInaA6xQksstza2
         VNqFu7xMhyFVGbwoRwQVDe2dhEOK/lGGa2GmGTjDnxhc1GLT7kw24Nsod6YXjDxPJX/w
         KLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529849; x=1789134649;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RloxBmq1OFFdMW2QFzzJPyBKTHQtM11rCubg4Pmtdw0=;
        b=pyV4wr9uc29Pkz1b3NS6p4wAUgm4GbnwLROBMQhAlqNmJVXhGsAjLdhKL0x7/azBYH
         80lajeo8LNFDyYF98hbmeW/I5tBJ+aoLMztMBa033g7bhxTLXXQxELwKSWbo3zetoaqd
         V8EaJ4jG3vuay7TufYnoD/I3two+NWWMxbujgw/Yuxr5nRwIfs4j1yiMITF6hEu+SjQP
         z+jObmOobXe29o67YyqOP+xrr7gllncBD6nPfTFI0xm9wIajjhLQv6uYjh/pL+As8pmy
         KuN7dOKew0qacE03GeDYTPRU7nO2iFTgeb7mywcQ34a8xTBUQGCIq30aQIwHrl+Cgjjz
         aItw==
X-Forwarded-Encrypted: i=1; AKwUvBzQJSZtuR470B+aoqMZB/yj+9DDk24V+w1fanL+R4SggmVhoGkjB/MbsMTuFUIlHTniAcs=@vger.kernel.org
X-Gm-Message-State: AFuF++mrZK5sX6PryCdVu6D8wQ4bcKda/Cb3+StgaZxfB3NkjDkT4ENq
	hQ09lX9JmaWOPoT1k4Za3C7rJNxVqcwt4i2jMcGqjQZweMDU0QuRhWgq
X-Gm-Gg: AYBFou1jVjtbOMDFu2c7Bm3T1V0nqSyk5IQEltuuiyfCe/pUG7wxJJbu53DViBSHItK
	dkhUWNIZrOHlNBRY09JYww0wSNlwEdDCCBH25Un4lzpe1UUv70CbQJHZnxsBZAD2zElYLq7BbB1
	6dFeed6O3/KvZA2aVW4+zATC0/HaxKauk7NTc/JsG3VczZmTtrRQCXqb8WyEuC0W6dwA8Txmeiq
	klm9pjosjLEDX/4ElaDCSdNtEmlzvlxwsYrmyWG8qsAMu7gAa0SYbOPMxHkuBfl5I7YvwZu7IVB
	tLzM8U3FV1ohNQdgLEqcoO26eASia8X9KZEj0enlf+0uJJYVYF17lImdGxyfFBU4gWeMbR+xUln
	+5rRzZavs9APrvnCHMnDWeatYms4x24lS1USUHBvHbapOyfGevCtsfoL3p05xYFFBc8dgTDQiBy
	Ueu2+l+DpTvvTvyQj1bxuGbdmiDjPToAUG274Nxnrqj9XKbzfmVTxtjGoL5OvdwazyuEzllqrMg
	WmW
X-Received: by 2002:ac8:5945:0:b0:530:42d4:4c9a with SMTP id d75a77b69052e-53054a34924mr61953591cf.44.1788529848638;
        Fri, 04 Sep 2026 06:50:48 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406940f3sm20714426d6.38.2026.09.04.06.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 06:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 09:50:45 -0400
Message-Id: <DL6KX0CC3BM1.1GLV02ZNIK4M2@gmail.com>
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Tariq Toukan" <tariqt@nvidia.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 <netdev@vger.kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Sabrina
 Dubroca" <sd@queasysnail.net>
Cc: "Aleksandr Loktionov" <aleksandr.loktionov@intel.com>, "Alexei Lazar"
 <alazar@nvidia.com>, "Alexei Starovoitov" <ast@kernel.org>, "Allison
 Henderson" <allison.henderson@oracle.com>, "Antonio Quartulli"
 <antonio@openvpn.net>, "Anubhav Singh" <anubhavsinggh@google.com>, "Bobby
 Eshleman" <bobbyeshleman@meta.com>, "Boris Pismenny" <borisp@nvidia.com>,
 <bpf@vger.kernel.org>, "Carolina Jubran" <cjubran@nvidia.com>, "Chris Mi"
 <cmi@nvidia.com>, "Cosmin Ratiu" <cratiu@nvidia.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Daniel Zahka" <daniel.zahka@gmail.com>, "David
 Wei" <dw@davidwei.uk>, "Doruk Tan Ozturk" <doruk@0sec.ai>, "Dragos Tatulea"
 <dtatulea@nvidia.com>, "Gal Pressman" <gal@nvidia.com>, "Jacob Keller"
 <Jacob.e.keller@intel.com>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Jianbo Liu" <jianbol@nvidia.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Kees Cook" <kees@kernel.org>, "Lama Kayal"
 <lkayal@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, "Mark Bloch" <mbloch@nvidia.com>, "Matthieu
 Baerts (NGI0)" <matttbe@kernel.org>, "Patrisious Haddad"
 <phaddad@nvidia.com>, "Petr Machata" <petrm@nvidia.com>, "Raed Salem"
 <raeds@nvidia.com>, "Rahul Rameshbabu" <rrameshbabu@nvidia.com>, "Richard
 Gobert" <richardbgobert@gmail.com>, "Saeed Mahameed" <saeedm@nvidia.com>,
 "Shuah Khan" <shuah@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Simon Horman" <horms@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Stanislav Fomichev" <sdf.kernel@gmail.com>, "Willem de Bruijn"
 <willemb@google.com>, "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next V3 15/15] selftests: drv-net: Add PSP HW GRO
 conformance tests
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260903085215.3691657-1-tariqt@nvidia.com>
 <20260903085215.3691657-16-tariqt@nvidia.com>
In-Reply-To: <20260903085215.3691657-16-tariqt@nvidia.com>

On Thu Sep 3, 2026 at 4:52 AM EDT, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
>
> Add PSP conformance tests using the same gro helper binary as gro.py
> does, but in --psp mode. SPIs are procured by psp_gro.py from a real PSP
> device and handed off to the gro sender & receiver. The sender crafts
> and encrypts packets in software, the receiver relies fully on the HW to
> decrypt, decapsulate and do HW GRO.
>
> Because the NIC decrypts and decapsulates before the frames reach the
> receiver AF_PACKET tap, it sees the plain frames and the assertions
> remain exactly the same as gro.py.
>
> So these tests verify, at length, that the device does PSP HW-GRO the
> same way as plain TCP.
>
> Additional PSP-specific tests are defined to check that GRO doesn't
> merge packets across PSP versions, SPIs, encryption-status, etc.
>
> Some tests from gro.py are not included because they don't work:
> - ip_csum: the checksum is recomputed by psp_dev_rcv().
> - tcp_csum: packets are marked with CHECKSUM_UNNECESSARY.
> - ip_frag4/ip_frag6: PSP is incompatible with IP fragmentation.
> - IPv6 extension header tests: PSP doesn't deal with IPv6 ext headers.
>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../testing/selftests/drivers/net/gro_lib.py  |  14 +-
>  .../testing/selftests/drivers/net/hw/Makefile |  17 ++
>  .../selftests/drivers/net/hw/psp_gro.py       | 172 ++++++++++++++++++

There's a chance I don't use the config snippets correctly, but I don't
include configs from parent directories. So maybe add CONFIG_INET_PSP=3Dy
to ./tools/testing/selftests/drivers/net/hw/config?
