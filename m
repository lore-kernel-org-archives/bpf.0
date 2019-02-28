Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF25C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E308E218C3
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DlDLnP/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbfB1SCF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:02:05 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55578 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731734AbfB1SCF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 13:02:05 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1SHwdMd108817;
        Thu, 28 Feb 2019 18:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=65eqXKqVqGL7LDJiHaWL+sDj+1lMiyMbbyxPDMpJhY0=;
 b=DlDLnP/Ys1iyAXxhFXZ829otVCD7XfcONG43d/uza8m+o4Rg1HdBGdg6vsqdhokolFrR
 qRcugsrmoAjL5Mu/E3zT1s+niIeO0ZmQzo++xzb6JtzLwaniRDEWO6VzygZwuRDk9xk5
 zl5RClOGI9tXhrsuGpcjvtoj9yPiSLjx33LI6RrHDeRQRt+QuALGp2t6xbHdEDwar3MS
 jNG91mH+n4pkV7nenEhuf+F/pkjAVjX3eLJOXpj8SeIeE0pnh1xKfAcfdCccGuC3Zm1B
 fbrY5z7xmR+lTuGhbT8OusawcFZ8swHiWc3yPZCi5gyxxlpFwpvziSFPczoJ8conhdGa xQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2qtupejve2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 18:01:41 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1SI1eLA028281
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 18:01:40 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1SI1eil008336;
        Thu, 28 Feb 2019 18:01:40 GMT
Received: from kadam (/197.157.0.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Feb 2019 10:01:40 -0800
Date:   Thu, 28 Feb 2019 21:01:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] tools/libbpf: signedness bug in btf_dedup_ref_type()
Message-ID: <20190228180131.GE9806@kadam>
References: <a34432d0-b838-c004-ef79-052cd50996c0@fb.com>
 <20190228175035.GA30148@kadam>
 <20190228175300.GB9508@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228175300.GB9508@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9181 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=943 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902280122
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 28, 2019 at 02:53:00PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 28, 2019 at 08:50:35PM +0300, Dan Carpenter escreveu:
> > The "ref_type_id" variable needs to be signed for the error handling
> > to work.
> 
> Does the infiniband signedness change comes as a bonus? :-)
> 

Oh wow...  :P

Let me resend v3.

regards,
dan carpenter

