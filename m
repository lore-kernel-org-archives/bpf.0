Return-Path: <SRS0=ACkJ=6I=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93014C54FD0
	for <bpf@archiver.kernel.org>; Fri, 24 Apr 2020 14:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C35F20700
	for <bpf@archiver.kernel.org>; Fri, 24 Apr 2020 14:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfSurklH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgDXOJQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:09:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47507 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbgDXOJP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Apr 2020 10:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587737354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YN7999rX4utRhqbmuRWdXiWCZb5Me/7HfCrt4nkY/sg=;
        b=CfSurklHNPhwCu7KQjk9WB1qEVGG/bz0YgzFGleNmG2Z2c7mWsbLk2uG8H06IhfUDdgz1p
        prJf3JYwn9KAG6im8qzlkF24PX37fhaxpuxe2+S+hCHJn8fm+rAW/bHhNMLvUwnYsg6HAF
        Y7WJJBQt29aSbyw2aE2nFO+oikcdxjs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-8u3nes-RO-GzCbtxI5fTiQ-1; Fri, 24 Apr 2020 10:09:12 -0400
X-MC-Unique: 8u3nes-RO-GzCbtxI5fTiQ-1
Received: by mail-lf1-f72.google.com with SMTP id v6so3955200lfi.6
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 07:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YN7999rX4utRhqbmuRWdXiWCZb5Me/7HfCrt4nkY/sg=;
        b=Bq5zXkOedfL6N+qzlW+SCQ1wTOA0PySPbSj7WiC8H0vCkCnf04A3OZjV002tnSthjE
         3K00IPUKU/6vNt3d/FEJm3dUkle6HfnL25FXsDu4kK5HNvRq16nBs/AX5ckWx7TAySR6
         sflTq5swlOwGtPP/HSnUWvBnZ2pCbu9aDvvmFtldO3Wr4kOnq/umFRJR+dKp97UTHmnm
         7hvHceSxoKVt4EnT/dfEgAf6AGPq1lrtvL8OLRAGIX17noHV8zZTrMd5c3WwU+5IiMmL
         EW6hNDTKMLDOOD9BdQauBnEIPRLgxZfHjDDMJfvUM7OZX9v3B5G3A1cgLy+5IhYvNC+3
         sbug==
X-Gm-Message-State: AGi0PuYF9OsdRIBVyTmVGU+OGLBlXadmLFPK7WzLfIRHgsJPs+wXwdcU
        DkDJL0EQvinuywnEyya6QVSpz3dyf410boad5nZ/imltLnPd8oV03d/eB3j3l5lkaLPIk/KXfSJ
        nf6qyjkC7RZto
X-Received: by 2002:a05:6512:1046:: with SMTP id c6mr6350115lfb.115.1587737350945;
        Fri, 24 Apr 2020 07:09:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypI77hXNzCROBvO6tUL4ElNeY8qsvtwRc8vAGThnY91mBNThLVAc58fyw7CrDrVU4ftrKSZDfw==
X-Received: by 2002:a05:6512:1046:: with SMTP id c6mr6350091lfb.115.1587737350711;
        Fri, 24 Apr 2020 07:09:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 23sm4265005lju.106.2020.04.24.07.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 07:09:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 27F771814FF; Fri, 24 Apr 2020 16:09:09 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, sameehj@amazon.com
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, zorik@amazon.com, akiyano@amazon.com,
        gtzalik@amazon.com, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        steffen.klassert@secunet.com
Subject: Re: [PATCH net-next 29/33] xdp: allow bpf_xdp_adjust_tail() to grow packet size
In-Reply-To: <158757178840.1370371.13037637865133257416.stgit@firesoul>
References: <158757160439.1370371.13213378122947426220.stgit@firesoul> <158757178840.1370371.13037637865133257416.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Apr 2020 16:09:09 +0200
Message-ID: <87wo652cxm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> Finally, after all drivers have a frame size, allow BPF-helper
> bpf_xdp_adjust_tail() to grow or extend packet size at frame tail.
>
> Remember that helper/macro xdp_data_hard_end have reserved some
> tailroom.  Thus, this helper makes sure that the BPF-prog don't have
> access to this tailroom area.
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

