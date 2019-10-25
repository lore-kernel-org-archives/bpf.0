Return-Path: <SRS0=fH4Q=YS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCDCCA9EA0
	for <bpf@archiver.kernel.org>; Fri, 25 Oct 2019 20:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DF920684
	for <bpf@archiver.kernel.org>; Fri, 25 Oct 2019 20:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmNuhs9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfJYUD7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:03:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47001 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726463AbfJYUD7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Oct 2019 16:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572033838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E26WgcwzyJ2kYdYldjeHK6d/+LLmrRMeJ9oJGNDaMNQ=;
        b=SmNuhs9uOr981dZPv3r0l/Jt2KmUuMEmrgdQvA6CXffsu86irEQNeiHCcmQhAutdIQy5rM
        GkFUCXg/Iuvu+RBSlBluKdSIJj+02g6RgJVYCb8g4QN+x88He5DZul/WiV5iYBPGD7tpjd
        TX1NtfZTZ/7iOMy6SoDQaZNatvlHW3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-QDhHsAe8P3SQUeXnGNa-WQ-1; Fri, 25 Oct 2019 16:03:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D24C1801E66;
        Fri, 25 Oct 2019 20:03:54 +0000 (UTC)
Received: from krava (ovpn-204-56.brq.redhat.com [10.40.204.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 60AD8600CD;
        Fri, 25 Oct 2019 20:03:52 +0000 (UTC)
Date:   Fri, 25 Oct 2019 22:03:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH] bpftool: Allow to read btf as raw data
Message-ID: <20191025200351.GA31835@krava>
References: <20191024133025.10691-1-jolsa@kernel.org>
 <20191025113901.5a7e121e@cakuba.hsd1.ca.comcast.net>
MIME-Version: 1.0
In-Reply-To: <20191025113901.5a7e121e@cakuba.hsd1.ca.comcast.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: QDhHsAe8P3SQUeXnGNa-WQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 25, 2019 at 11:39:01AM -0700, Jakub Kicinski wrote:
> On Thu, 24 Oct 2019 15:30:25 +0200, Jiri Olsa wrote:
> > The bpftool interface stays the same, but now it's possible
> > to run it over BTF raw data, like:
> >=20
> >   $ bpftool btf dump file /sys/kernel/btf/vmlinux
> >   [1] INT '(anon)' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3D(no=
ne)
> >   [2] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bits=3D64 enc=
oding=3D(none)
> >   [3] CONST '(anon)' type_id=3D2
> >=20
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>=20
> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

[root@ibm-z-107 bpftool]# ./bpftool btf dump file /sys/kernel/btf/vmlinux  =
| head -3
[1] INT '(anon)' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3D(none)
[2] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bits=3D64 encoding=
=3D(none)
[3] CONST '(anon)' type_id=3D2
[root@ibm-z-107 bpftool]# lscpu | grep Endian
Byte Order:          Big Endian

thanks,
jirka

