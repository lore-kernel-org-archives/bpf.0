Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B152F49F4
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770408576; cv=pass; b=abiJzUIbB/BRvPwz39HCxJXyaWG69Mj9VEysCBJHcGX1QE5g06E0ScocUdKWaE+t6oF/cX+u8ftZJQOMu3VslABy+uKe1p2UXEME7fkiCGZJUXWxttqRZhalS2Iq57649VuS5+SK6nmweULfau7r/hV4lQwvo2pyz3HtL6UpKE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770408576; c=relaxed/simple;
	bh=KNkzI7/n94xGAZIGiTH3Axn/jOrvmAt6C/cefa5sLOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TY4ltAMCxKDshhxgDeGf8vSSukRSowZ1mdlNzuwDxJuGP7aHk+jeMc+Ywi8B1Ye/f6c+S1oGyAArekFWt5k4FMYHXBIJvC98UDroMx1PQNBox9Wk1Xg4ja0/COtjyND52NBzvVWVmRxwgz8lHgXDYVH1AgDjK+4e4NhP8xJR8Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpvnvAGb; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpvnvAGb"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432da746749so1657994f8f.0
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 12:09:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770408574; cv=none;
        d=google.com; s=arc-20240605;
        b=Jj7YhYt42yyJGVZwueTBWvUDBLYPJU+UY8KkgS/QhT2LcBhdO7W4KProkBGsACKLIC
         MkcWl549GroKZLr9cHnB3i2X41nEOslf79/FmtnJ3Dd0tAJrXQhJOHvIYje7XkP0ppQ7
         tKdyUGyJ7sw6rur7Zn1cJA72L3ubft+InlyY8TUr1N47aG/4vBq5LqcXWt2iszZGLPyQ
         laKl6Ubj6pw/oN0NZ0ekLM84v6T+l6+olRkt+yEnGXjhbJTtrIHMhVO+lPkeCmFAYEs6
         7nmgiq11Ibt8qhmvBlFJvzvh/GT71Z5rBvSufua0537ME7CYbmwaCvNL3sHHfnr9+l8f
         urwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNkzI7/n94xGAZIGiTH3Axn/jOrvmAt6C/cefa5sLOQ=;
        fh=tlGeg6CNTheby73D/I/yVJ8TkCO5YNOIGdJmRGbDtZg=;
        b=bSvjxIDR+DZavyetA52RsCYuXiHAd1Z+aogtk3D3sRRNI1/P8GPd2VmId8kj+ZaC68
         HvxyG5XkAJBjcnDxDvMvHiGfPWRrWPG7jFgFUwqRsnoGOK0Rl2CBg+7/OHTnloHAF4ox
         zgzkSB+TcNP2zsBJeMx5RR3WGIDgmgyRpnO+hes7LqJniaFpoczWw+TeM81tx8P686pP
         vOIVKzLStB9hzPAbeQ6b2qE0W3cqLAPkgXtgL65y9le+PwUq3xAHNTQG1vUVQ/l3iRtu
         BBLKwzXLZxE2+opq5Wr9SkSvo4W8ywVY9HC8i8z8V9hVRlfCezBYt67rwgQC+8MkCIYT
         zn5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770408574; x=1771013374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNkzI7/n94xGAZIGiTH3Axn/jOrvmAt6C/cefa5sLOQ=;
        b=LpvnvAGbWWDxOeJzNJJOc2f3M238KYr8Xv5nOMfKoD4rHjknmiBMNNyUpFRUNfWV+s
         XXI7vOLWv3zeVnuTe55oQRH8e/3Ct0F1ivgZxCMsa+vnec3L3FQR2iOMNc7thDiVxkZx
         GYLeJ7kTubyacbWX9m3eKwdDFP3GmRSLyunjwwwgqxgbWImqATmkIpiM7Su8xRL0yxYJ
         y5c+hrpuSXjwLOg+NSxUkbFvj3QUiVNPft8fiM/3x/BFmB6UkVjugi93IqGDdRwN2hU7
         C5ZKoJUMP+D6FcvSlMrzKxl02+DNRJbhVVwIRMQWdDAo8dRTMpn4wM/hMH8BAYFdi1np
         t4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770408574; x=1771013374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNkzI7/n94xGAZIGiTH3Axn/jOrvmAt6C/cefa5sLOQ=;
        b=wYK6CQraL1/ttsDLyk8MvKjegl3G1PUEatdUv6CJn3D6tk2daFs9FPxyST2TfT9VRc
         MpIkEEh0ijdULaEdTC/yUe+3Qr78XJxKxKxXcrxH8znH2shOSbEc3nkIXHO0g65DiP38
         c9VDxd0wqHTXQzfzud3vcKNkYuSwsKKEyKRz7XG7wBPt6k5FoyEdoqniMwOadFW5+SOd
         ecwjMQif7vesbDLSe8IXb6nyMtQVH0NDHDNOQn2j48DXiZja+ZsaojYR6L/deV7pZlr6
         Ldb53YN0iJ29Mi6RVPqpMr1CcWpadHVPTdhffnhnDSgwuCAdqJIud8IVOxY9QhuA2L0K
         iEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYcfOVA5gSZos7Mkwf1W1GQ5mrxC8zWOw8GEvlI6uW+Kre1TFGDPOE7wKOpN8Y+4koyhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb3PWMEb43rv01SqYx1eKuVkgo5lO5/N5AFXB/5+FgW1BpumaZ
	CfBbSDhn30TbF5hgcwELuZZF6SibiGed/hCXc6EzV4rdJBCCWYyg8+L7xNE80q5WCFpB6CHTpvk
	hkvONwCoapgCqWXAqlVm5Q4NAWYS9APw=
X-Gm-Gg: AZuq6aIxJmOPSR4Tlf4VVNI4Mh+r1h/apSkzULrscYtneTgJUVxKGGiKWCg8YRIGvDm
	ne0l1GF6oBUfIMkiW/9JFA+ac6cpSzuPJ1BBdPiRRREbN/qSduOsulnQUu7lx7HItn/aBknsuY0
	o+HrHxH2N8QP6s+t9DPT3k2eDM88x5+X+rSRu1kIp0RIS2hFhLxhy7w3qtPGvqeDJvu7wCEfMng
	wA5xQxM34cmq3X4SlhJe1jz749vEOV5u7UR5+OiRncJ+RP5V+enAS9w/0eV6rK21Iaa+8MUrRt2
	ySNREHQRmW1bHbQ9Qrrmbi4ZPeihOeV6v6B2BWa1h1NzIEDSNIHM6cQAEN03hBI/O0jCSGj34TT
	HkrIMwCae7zNtkg==
X-Received: by 2002:a5d:5887:0:b0:436:184b:4148 with SMTP id
 ffacd0b85a97d-4362965207dmr5961241f8f.3.1770408574080; Fri, 06 Feb 2026
 12:09:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206093410.160622-1-harry.yoo@oracle.com> <20260206093410.160622-5-harry.yoo@oracle.com>
In-Reply-To: <20260206093410.160622-5-harry.yoo@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Feb 2026 12:09:22 -0800
X-Gm-Features: AZwV_QhYNWBSDD-nTmAfJUx6ToEdVRJ7ZfLrAjTMeLBCvJJlvn_ysojVswF6Q_k
Message-ID: <CAADnVQ+rNYeb5Pu2aHRVc+hYDeAF5t19MVwzXsyn2HkOuLPNLg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] mm/slab: free a bit in enum objexts_flags
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 1:35=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wro=
te:
>
> Since kfree() now supports freeing objects allocated with
> kmalloc_nolock(), free one bit in enum object_flags.
>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

For patches 3 and 4:

Acked-by: Alexei Starovoitov <ast@kernel.org>

I think patches 3 and 4 are ready.
Would be great to land them for this merge window
(if Vlastimil agrees).

Patch 3 is tiny, but the impact is huge and
patch 4 is a very nice cleanup.
If we land it now we can start using kfree_rcu() on bpf side
in the next release cycle. That will help us a lot.
