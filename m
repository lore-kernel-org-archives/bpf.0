Return-Path: <SRS0=DkpX=4P=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20339C4BA24
	for <bpf@archiver.kernel.org>; Thu, 27 Feb 2020 08:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5782467F
	for <bpf@archiver.kernel.org>; Thu, 27 Feb 2020 08:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsPT29d5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgB0IId (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:08:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42008 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726999AbgB0IId (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Feb 2020 03:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582790911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fXN+R4eve0isDo+ppsS0heZKFVC7J36x/5W/zSqTBvc=;
        b=RsPT29d5SGfCLPU+8qL6UDfELEh/gQbEjoNU/VYnzRe8Z4furqGQUC1Yz8pa7vtzl4xDNh
        cgmLDTg33v4vnFShPz30ZL/iwuDLhqxkOcp14LHi5y4/bhoKqVtciQ1venTLTtRuPkgsnd
        H/jgWApfMRWTvN5AVBi6Eqr9AHfPYic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-d1SCo9fbP52lGSCAdHhVcg-1; Thu, 27 Feb 2020 03:08:27 -0500
X-MC-Unique: d1SCo9fbP52lGSCAdHhVcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65D9D1005512;
        Thu, 27 Feb 2020 08:08:25 +0000 (UTC)
Received: from krava (ovpn-204-93.brq.redhat.com [10.40.204.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B619319C58;
        Thu, 27 Feb 2020 08:08:12 +0000 (UTC)
Date:   Thu, 27 Feb 2020 09:08:05 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@redhat.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 12/18] bpf: Add trampolines to kallsyms
Message-ID: <20200227080805.GA34774@krava>
References: <20200226130345.209469-1-jolsa@kernel.org>
 <20200226130345.209469-13-jolsa@kernel.org>
 <20200227062640.4srlnkxvtw34jml7@kafai-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227062640.4srlnkxvtw34jml7@kafai-mbp>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 26, 2020 at 10:26:40PM -0800, Martin KaFai Lau wrote:

SNIP

> > +	ksym->start = (unsigned long) data;
> > +	ksym->end = ksym->start + BPF_IMAGE_SIZE;
> > +	bpf_ksym_add(ksym);
> > +	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF, ksym->start,
> > +			   BPF_IMAGE_SIZE, false, ksym->name);
> > +}
> > +
> > +void bpf_image_ksym_del(struct bpf_ksym *ksym)
> > +{
> > +	bpf_ksym_del(ksym);
> > +	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF, ksym->start,
> > +			   BPF_IMAGE_SIZE, true, ksym->name);
> > +}
> > +
> >  struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
> >  {
> >  	struct bpf_trampoline *tr;
> > @@ -131,6 +148,7 @@ struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
> >  	for (i = 0; i < BPF_TRAMP_MAX; i++)
> >  		INIT_HLIST_HEAD(&tr->progs_hlist[i]);
> >  	tr->image = image;
> > +	INIT_LIST_HEAD_RCU(&tr->ksym.lnode);
> >  out:
> >  	mutex_unlock(&trampoline_mutex);
> >  	return tr;
> > @@ -267,6 +285,14 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(enum bpf_attach_type t)
> >  	}
> >  }
> >  
> > +static void bpf_trampoline_ksym_add(struct bpf_trampoline *tr)
> > +{
> > +	struct bpf_ksym *ksym = &tr->ksym;
> > +
> > +	snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%llu", tr->key);
> Do you have plan to support struct_ops which is also using
> trampoline (in bpf_struct_ops_map_update_elem())?
> Any idea on the name? bpf_struct_ops_<map_id>? 

right, I was wondering we should also do that,
I'll check on it

jirka

