Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5C272E6D
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 02:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070478; cv=pass; b=ada3MQMPOk1HoMXIjlwN4s1OT0Iw+wkuSRuTfPVAfh9SJUpe3Qpy12Un6hEOx7svE6pDcKnrRBEIAyiNaQ5ppqumO+G90GyJGeqKkpWiKmQBmt+byl4PoAfD3fenAFWlsK4vQrKKljFcZUbdawYACHtg9M0yD0jga/w6k/KnfEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070478; c=relaxed/simple;
	bh=6EWctOxAWLRCc3hTznphIkPrW49vIH2Teom9K5/kdnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvFKsy/e+4HRPkzDyz6i5DiH/SuoQBvxPjyIsHYH724p3bA0rD6Q0tPS+VOKKpfdwrvm7pyD5QY4HqQkEJiZx7IU9BAnj6bY+eGz597l2+261vMhNfBHGTpX24PDyYn+VyhkeK0hTspEjKu+yYkfZ7iXEiB3p707d4mzo7/ieVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EDO6/dVe; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDO6/dVe"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab97c86bdso37365ad.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 19:41:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786070476; cv=none;
        d=google.com; s=arc-20260327;
        b=WY7PprzZsOfDvnsAC4poV1gb0ROSfv7iSibauRIY2vXZB93iGNiPJNK439WLHMZ7MM
         LL+cZ8WzkMeuGIERHg7GVdMSK6FzxBhg1Eyg+G2L4dwrylpfsQEFztcaDI68mtSx+gJ5
         MjRaFT1fKUqGSyRnRHOYHXkmLhLcMjcWyQr2N23ij43pVxnotgd3/dn8C7FFp1HyolJM
         u/9+JzVpKMmE3BhLc4r7dpBKUrRYIE91MinfDETO//u9nFsXXwjcK9sT1qzazYB9eWMy
         3W9BtqpH6I5uWTikh6QUviX+gAGHzGV48iB9vGkKQ4RYk51nTeVWfrnhefjsB4dtz9BG
         Q/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ohem3ALx0oIURkSK0DNHfCt3tnXEbZJxRR8T9mkrZcA=;
        fh=uzUraRJAKhl4K0CCetUeI/abDNRUNXq1Jh2WnJZj9v0=;
        b=p+l6GUXCFmMHP8MOx5oviGgNdL4HraA/VwHA5P0X8Sst+RUuMgGC4h/XqQiCDd9QHA
         iZ8SOhTTtDARaBD3ZJt6izf/uEAJYLQDaos+UbUGS9CtCgnYPCJB7+12KE5QL9qW6RvG
         mpc6jwvVFhNKj2bhV2M2b2z7EbT+Cfm9ZmXDbcbBQxZlo5XVxdcwRf+7T0S102baTKFp
         kzmLkzmJ9yGFjzIBDF9cmuejlsE6Ds5KbaxTRk6Nk1FjtzMfRbQPDGUDG1GLyLM/wwR6
         gt2UCc8+Kh9T10QYmxjSxsgNGJyByoRZ67CWtRMGZzov3nh6uSXNIrNqcfONPlG8OpgC
         wCaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786070476; x=1786675276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ohem3ALx0oIURkSK0DNHfCt3tnXEbZJxRR8T9mkrZcA=;
        b=EDO6/dVe8/2MyjE0zXNpCLC17sWPh/z96mnBWcCBapnV6KQVsh9drgnUrIzgyx+ar1
         iZ/xK2PcVUI7Oov1yvx6s5vFmO+phjCkTHdLdA8Mxv5LzwPCdDVdPMbb38R4c9ZEclYl
         u9hNb0Ht174RQSp7XG1tGjLvN35YyHDYJQqAshtm5hFVuC7+LI5yfQQYtBYLxW3ISfLl
         W/LldMcW7vGOBJrly7RF1MZ4V2JePZbja8vScf1v7aLTSPc0d3FyxjiPUbdyYUR98YFu
         7DJJSxJKlHMPvCoYs9vSZV5WfipvJ42oM5GGwpmcMve/k30kD39MYuXvqPnmE45W2hMW
         xdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786070476; x=1786675276;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohem3ALx0oIURkSK0DNHfCt3tnXEbZJxRR8T9mkrZcA=;
        b=M5FQvUHyAnhg51hbjTzk+ibRpaCQOgC+sCJtxz3iuPWBtPTKjB/sQT+tJS1dFzIRRg
         a4x6IqJSC8/EuMh7nzdbj8SDAQx+fZEn3w1nHSWYaHs9hIbRausaqM6HTkBJVz1kpgWx
         y3BsUiyiVMzY18Tp46ylDlJ8EnoOYiky0oyCNEpgXGB7NgeIRZaF+L+vvOdOGggGZVyk
         xp2T1jWK7YK3jNDtjvRdXk6EJ2itvthTTZX3czHy+BzT+Ggj4Jog3iObvVb64M9AG3R+
         jfQvH6va5snqB+NOMEptKj7eJa9YPIifIKwS4QEyP3Q80oFPWrIjhTupm2t0GYtVvops
         6duQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYL855mmTX2aTn/rG+hIa4Q4jzWe0Y78S4h0Rp/W40UCMnez+u1RG95nPa2UxOK19koe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSmfydhjTZ6cuwdgCx2Rm/qkAYITF0RNcpEM4b4+g/oTV1A1vk
	G4mZ2ClA093YUDlaEB5BEtT3sJpen+mHvk6Vf05Hw3eJIxEySLEgxKE2ZATdiw3s+yQ+6SDnsib
	eR8v3kJY2gUw1ql1CRkWClownBSLe5AlClQ5ZCRPt
X-Gm-Gg: AR+sD11OHG48Yfxs74R57pQdbLF0xfARwKQhvHjFdLuhzuPSpjdawbKhY1kz9Lqrudw
	eOBQPAC9MT1xW4BwhIkFlqgabks60vFI9jb6D8QsRIK6VxR7VWEQJULFZjb3vXPjWQcwAP++3c+
	0h28FU3ZyK2jkckHhgAsBhoJQRKxZOUM8wZU0R+UlXqhmLofLzhgIZ9IOgfx0LYOWQSx698xGfY
	xylgwhOfjJIKK1JueErfDLz7obeQtW87s/kAALb204jGd68c3GbQ2Fpg050r964tBugBAIpdCVN
	eEjcC4aoQPGK6VcEClZIjiC0cFgj7BS4ibY5EbMVnQUEbK8trysEo0ZhXS/AiOhFIZfYnzWd3r9
	BH+9WkrLz0n7EXT0xHPZdFa34qI5IIy8RAoGfk/ZaG69gRQ==
X-Received: by 2002:a17:902:d50c:b0:2cf:9ec1:ea6e with SMTP id
 d9443c01a7336-2d120427dcemr4473575ad.8.1786070475498; Thu, 06 Aug 2026
 19:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
 <20260803184630.3813311-7-hramamurthy@google.com> <045c0ac7-c784-4162-a01a-1a1d8f8377e7@intel.com>
In-Reply-To: <045c0ac7-c784-4162-a01a-1a1d8f8377e7@intel.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 6 Aug 2026 19:41:04 -0700
X-Gm-Features: AUfX_myquY2_EEFaQMQmJpcrA_JutQqi3BzmVIZBqAI3DAhyAGqfuzR9Umj2n3Q
Message-ID: <CAEAWyHdh3+mO=+b9Zmt1dLO5-x3bhF1ZcC26wsbcnf787MyY2w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/15] gve: introduce ctrl ops to set vectors
 and Qs
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 12:33=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 8/3/26 20:46, Harshitha Ramamurthy wrote:
> > Introduce following ctrl ops for Adminq mode. This change does
> > not introduce any functional change, just movement of code into
> > ops.
> >
> > - set_num_queues to set maximum and default TX/RX queues in the
> >    alloc structures used in the initialization flow.
> > - set_num_ntfy_blks op to set number of vectors(ntfy_blks) in the
> >    initialization flow.
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> >   drivers/net/ethernet/google/gve/gve.h        |  6 ++
> >   drivers/net/ethernet/google/gve/gve_adminq.c | 45 ++++++++++++++
> >   drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
> >   drivers/net/ethernet/google/gve/gve_main.c   | 64 +++----------------=
-
> >   4 files changed, 63 insertions(+), 54 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index 56148ea3cfbf..1bc5e32b6618 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -829,10 +829,16 @@ struct gve_device_info {
> >    * struct gve_ctrl_ops - Control plane operations structure
> >    * @map_db_bar: Maps the doorbell BAR for the device and store in @pr=
iv.
> >    * @unmap_db_bar: Unmaps the doorbell BAR previously mapped by @map_d=
b_bar.
> > + * @set_num_queues: Sets default and max TX/RX queues into allocation
> > + *                  structures stored in @priv to be used during initi=
alization.
> > + * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used durin=
g
> > + *                     initialization.
> >    */
> >   struct gve_ctrl_ops {
> >       int (*map_db_bar)(struct gve_priv *priv);
> >       void (*unmap_db_bar)(struct gve_priv *priv);
> > +     void (*set_num_queues)(struct gve_priv *priv);
> > +     int (*set_num_ntfy_blks)(struct gve_priv *priv);
> >   };
> >
> >   struct gve_priv {
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net=
/ethernet/google/gve/gve_adminq.c
> > index 9c3ebdb547cf..1d9ae601cdeb 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> > @@ -1612,3 +1612,48 @@ void gve_adminq_unmap_db_bar(struct gve_priv *pr=
iv)
> >
> >       pci_iounmap(pdev, priv->db_bar2);
> >   }
> > +
> > +int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv)
>
> Would be best to change patch 2 to introduce this in the gve_adminq.c,
> to avoid trashing. Same for the other callbacks.

That=E2=80=99s a good suggestion, thanks. I will move these functions into
gve_adminq.c in the patch they=E2=80=99re introduced to reduce the churn.
>
>
> [..]
>
> >
> >   static const struct gve_ctrl_ops gve_adminq_ops =3D {
> > -     .map_db_bar      =3D gve_adminq_map_db_bar,
> > -     .unmap_db_bar    =3D gve_adminq_unmap_db_bar,
> > +     .map_db_bar             =3D gve_adminq_map_db_bar,
> > +     .unmap_db_bar           =3D gve_adminq_unmap_db_bar,
>
> pleaase instead use final spacing in the previous patch

Ack. Will fix in v4.
>
> > +     .set_num_queues         =3D gve_adminq_set_num_queues,
> > +     .set_num_ntfy_blks      =3D gve_adminq_set_num_ntfy_blks,
> >   };
>
