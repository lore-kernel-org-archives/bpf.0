Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B70387378
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936601; cv=pass; b=s0cun8aceBTMQiR+fl2g146X6cOq9P0LPDt1DzWaW5hV4gxZjMHl/5BmNXg0pdFtQ6OJzVgbpiLoPHN5dIWr0Ytjag0iyytAo4pJKyY5FyOKEvPDCBvxW/2pulqwK0cw1/GrN3MmMBrc1eC7VLabsvlWSBc2/EYxBcivAQZfNxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936601; c=relaxed/simple;
	bh=wP62moPxMAH/ckYjnceOzlKQcAACIf9yQB3gQOrPKi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qighNjtrSOinWmTCPUqwCRKdff7hN/OS2H5o6SooL+KVQOffWgbX+Q07UraxJCEDv6kUhaUucjIcY7TGX/KZ5QiW8AUj9L7Ru7jBQYIDCKhXaQtXrxFsiBLlSe4e/QeyAp4YL0qY1vaqapzZxiktjiT1pjhbeh0MBz5BQo7HeB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gBPDN3yl; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gBPDN3yl"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1887987a12.1
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 10:03:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787936600; cv=none;
        d=google.com; s=arc-20260327;
        b=ZlxIeC5hR+LBHyBv2sAaVTaCWqVeHDkEZxJXo9jdjcvM+PDmZgnAeqqzV6NuLpF7Et
         +UTQ3LAsVItfTbBkrnA4IKSahUYJDkqixYFdgFgUT8wHy8GsIakaEhavUntbaJeLKO1/
         KkDrYDTkZHrE6Ptk6cH2RWN8HDyD8DS6wNxNEYtyoyn2Q/5aNAxaV86H9Io5hoULA+bX
         7K05R39+LGmjaFMdqnMRhcsmqACsYtYjMWWgvQVKrBALcAaH9eoSn8icIHhpMd+6ZJGg
         nen5t6efU4lF6qP1leDbby4VcqUblhey+Mx+frHUrQJFDpYg8EQhG0uJZbnYuqYOmIUE
         w7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3D9xQtFnagYVLW4vz/xB8xNx9SMn/YPoGUoz7up9AxU=;
        fh=EJZ+zNIryXJBwvyEOmO7grN1Aq3YjV6y4nqNUHi+sXM=;
        b=nyk1NwG6jSuF3F6PjUArV0jTeYsIR9bdMKlH1vH9fxotAcmnZWQfIlMi+B29gYE23a
         Dr0Z0ECmrw7WA6fTNwzVC0d5DOCWSp/sLU787hJ9NsMyZC41gYhTaLereECb/AS2rKZ6
         a4mk7yhQUeHv5hp++kLZ+RGAxH27+LPalFS6yRCYhAmtCMWAgtIm/zhkXLoCZ0mZdhD3
         gCa2yvV/sHEjlIH4eTvysClbRbbvE7ATTIub0nFL06yG+1hXGHUzP9gACbK2DdwmP3hR
         sWguKMeo0hWBnmOBhFPNxtFC7ON05kmYeBwIiVTWLnFs1naapmUOb0ivhC/69N2ks+K+
         FKzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787936600; x=1788541400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3D9xQtFnagYVLW4vz/xB8xNx9SMn/YPoGUoz7up9AxU=;
        b=gBPDN3ylyBZjzTKa7/C5y98b18l1cCoPCjwkqSMrOCExe2sRsEDmaHblE8Ip0g6Da4
         zlE59uwWis3PYnpXMXO9TxNcXxNR8MgOZD3XoJ0vg0bHZnll0lmOhMR6eZ50OWwrNWcK
         Icit+Avggf/xgulUKd08ddZ8jGyUKIuq7n0uoT7zz291ZT9J6ZiEsg59NvSUW/kCwBZj
         mBxSqZ535brwNZZtSFZYvNlykUKfm03oZdi/7eUHJ1pyj2iuPfMBpkf07F46MaAMB5xg
         4D2ZTGnUGF9GNm3nb+f9jgHlVwvDQPd3hiPUGItrDnjaErbSuQCl+eOoShuRmA3m/tY2
         +h1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787936600; x=1788541400;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3D9xQtFnagYVLW4vz/xB8xNx9SMn/YPoGUoz7up9AxU=;
        b=IJ9vtEKA8sy5hy7gc3+ixrpHKvXrQsfYADcDfHsqskqqo0OJuV7MavvhHy3ya12LzS
         /RFB6Y9mabkELXQ4J1r9J0agDTVHJL0drFFqG5cxryHmaatAiWHVW00AlFyeuCDecLPR
         c+OIhJz6F0PXRypKJ27m59c736xeYZ0+hdH8cnao/Rwm1ade7lZotZmyGBjhqmNgsdm/
         Qkwsv9+TyxCNOotCIgZCzbooxR7NzptTS5wKCDgnv5xhEi4pmS8kbfVp/Dgu78JUM1+l
         jdAZSVso4/AdL8yZabYVT9bT2iI6gU5G1DYGdajC1TYT10gsLlfWOQweXIRx4qkVdxQr
         5v0A==
X-Forwarded-Encrypted: i=1; AHgh+Rr5ninEXR9by+VUVv0UV4cywF8vcd/TZmgB6qnLzBJTjzt2C1n64KR0KJJ5mE+SDffs+u4=@vger.kernel.org
X-Gm-Message-State: AFuF++nmvGBk+O80LI1ufI3Bubrrx3UJsSDyxPmOYL+LISWNb1X0OGAU
	hf4aIkXX58w8/2ZpoTfX3UQFKvlaPlizIz90n6T8e15dKH01AdvY2820VQW6vhbef3dz/51+CUk
	S78S4GGDtpBiRTDnK0qVlktGnJDuhEGUu52G0hn+D
X-Gm-Gg: AR+sD13+6oiGjkC6Kj5X677GOChevKVjB8lfTzuc/8nrr0UBWDZhLmqSfw39+Mn7Tsr
	5i/kRlqJxEvaMKehU0U9U0lAQ4mSHc6ReTagQ6XNWhMGAA2EaxP+fJ9ugiJa9HNUfHoB8TlgoGP
	8FEd1PyPFf+n3E92o6n3rHa1BxhDNFeDrosqEh+xvb2ejH6gcBSsF47+ys/i+9JDw+Im8gwcGLf
	qpUOvxVi3fvgYna6sIb0cBkfCYCO2f2On81ivV5KUCmkhC2EUkTMF2TtheZ5PJpURbjlNY0+B67
	gli7xYlBFQ6tbeenJc2oWhH93Eqa+9llZCCcaAksrhazQR/dZvbaSYidNPI0PtG6QL0zzXQezMc
	DOZYoAFdHoEXjLFvcaDJIW05GJSIqwtR2X2o2Z/rV4QY9VMAPSIjlzkGw2wszQ98nCYvhFOi7qa
	jk/dMJQvc1e3OuQ7g=
X-Received: by 2002:a17:90b:4e88:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-3969bb05e4fmr23190637a91.8.1787936597976; Fri, 28 Aug 2026
 10:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828164918.451364-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260828164918.451364-1-maciej.fijalkowski@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 28 Aug 2026 10:03:05 -0700
X-Gm-Features: AcwNN1UazCKsXBt1bQZ2-rlEPqZo593Iv86LFjnUhcYSmeB20RqI5rKuNU43TFs
Message-ID: <CAAVpQUDEXAOc5UeMwDwFMBgxV3gONM4qDU6dHQhyCgjef5DpLQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] ipvlan: unregister upper devices outside pnodes_lock
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	magnus.karlsson@intel.com, sdf@fomichev.me, bpf@vger.kernel.org, 
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 9:49=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> syzbot reported the following circular locking dependency:
>
>   xs->mutex -> netdev lock -> pnodes_lock -> net->xdp.lock -> xs->mutex
>
> The pnodes_lock -> net->xdp.lock edge is recorded when
> ipvlan_device_event(NETDEV_UNREGISTER) calls unregister_netdevice_many()
> while holding pnodes_lock.  A nested NETDEV_UNREGISTER notification for
> an IPvlan device enters xsk_notifier(), which acquires net->xdp.lock.
>
> Keep pnodes_lock only while marking the upper devices as dying, removing
> them from port->ipvlans, and queueing them for unregistration.  Once the
> devices have been detached from the protected list, release pnodes_lock
> before unregister_netdevice_many() invokes notifier callbacks.
>
> The port remains alive across unregistration because
> ipvlan_device_event() holds the reference acquired by ipvlan_port_get().
> The dying flag prevents a concurrent ->dellink() callback from deleting a
> queued device again.
>
> Fixes: 35add1093e2f ("ipvlan: Protect ipvl_port.ipvlans with mutex.")
> Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Daa48b5fe7bfda62d1682
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!
