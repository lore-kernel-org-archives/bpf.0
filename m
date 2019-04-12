Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6745C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 06:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E68F2082E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 06:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JjAh9366"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfDLGdE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:33:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54476 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfDLGdD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 02:33:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3C6UR7P013822;
        Fri, 12 Apr 2019 06:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2018-07-02;
 bh=UeIOcndIM9anjeU+V6MTkKczcrr7h5JzHFNseSXP2OA=;
 b=JjAh9366hNofjFk2jCpp7YA1ld5KBYw3KOraeRnVsxvx6QXNomF/vn3X5v02JAKaNybp
 Z2jRxlxzjBLEUQ+ODq+M5Z7+uOANxKx5q3ecvcIU1mrquBM3IamWRJ61J/NpTK3UohDw
 skmRtOWhQlpZuJPmRwn8qKUbfMEjU9on/YNKxW/DJB6ko4OI/Gqepwyf3ruljNYiRpZl
 si1txxZwnc060+GyQzl9AomutfdwNChkW1hVM+jvgKVQIRUPp2K4LhZiEcwpzrStjLIQ
 dwUDiYyEvUQT4ssQ15WsuoExiadlihZiUnRJmwnOCbGU4Nvht4wbCmtl8RhGB8OMYN8q QQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2rphmevtmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 06:32:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3C6W0Lw120550;
        Fri, 12 Apr 2019 06:32:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2rtd84cwg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 06:32:32 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3C6WVsG008161;
        Fri, 12 Apr 2019 06:32:31 GMT
Received: from dhcp-10-175-173-239.vpn.oracle.com (/95.45.15.14)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Apr 2019 23:32:30 -0700
Date:   Fri, 12 Apr 2019 07:32:23 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-173-239.vpn.oracle.com
To:     Song Liu <liu.song.a23@gmail.com>
cc:     Stanislav Fomichev <sdf@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: bring back (void *) cast to
 set_ipv4_csum in test_tc_tunnel
In-Reply-To: <CAPhsuW7a0XxoFF0V5TFRYqAKHu9_d0gfYGTnfTcEWch1sTBung@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1904120731250.18008@dhcp-10-175-173-239.vpn.oracle.com>
References: <20190411225316.125106-1-sdf@google.com> <CAPhsuW7a0XxoFF0V5TFRYqAKHu9_d0gfYGTnfTcEWch1sTBung@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904120044
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904120044
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 11 Apr 2019, Song Liu wrote:

> On Thu, Apr 11, 2019 at 4:08 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > It was removed in commit 166b5a7f2ca3 ("selftests_bpf: extend
> > test_tc_tunnel for UDP encap") without any explanation.
> >
> > Otherwise I see:
> > progs/test_tc_tunnel.c:160:17: warning: taking address of packed member 'ip' of class or structure
> >       'v4hdr' may result in an unaligned pointer value [-Waddress-of-packed-member]
> >         set_ipv4_csum(&h_outer.ip);
> >                        ^~~~~~~~~~
> > 1 warning generated.
> >
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Fixes: 166b5a7f2ca3 ("selftests_bpf: extend test_tc_tunnel for UDP encap")
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> Acked-by: Song Liu <songliubraving@fb.com>
>

Thanks for fixing this Stanislav!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com> 

> > ---
> >  tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> > index bcb00d737e95..ab56a6a72b7a 100644
> > --- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> > @@ -157,7 +157,7 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
> >                                        bpf_ntohs(h_outer.ip.tot_len));
> >         h_outer.ip.protocol = encap_proto;
> >
> > -       set_ipv4_csum(&h_outer.ip);
> > +       set_ipv4_csum((void *)&h_outer.ip);
> >
> >         /* store new outer network header */
> >         if (bpf_skb_store_bytes(skb, ETH_HLEN, &h_outer, olen,
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
> 
