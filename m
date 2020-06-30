Return-Path: <SRS0=4Gtr=AL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0970C433DF
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 20:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98DDA20768
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 20:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O63miGTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgF3Uci (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:32:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36782 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725872AbgF3Uci (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 16:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESBKU9HnoPTqnSO7J/1b1dx5zSIlXSEN4Rn3HBbqK84=;
        b=O63miGThG1QsbUXnnGhq5OQsWvQDAFmudePSl2HoLUrpb5XbIR7x4Pr3REkOoIgXpCWmgZ
        77csXJrqvEHu+HV6+PDOVmkFC60aDfqILtMktcFLAcM9Skw8b/GJvlNMoXxNSUjtLuFjPU
        JYg9RYiZO1hpMc1UaXwLb4J4ocX1OWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-ttYQlc6AMTuVFf-YHHqpdA-1; Tue, 30 Jun 2020 16:32:32 -0400
X-MC-Unique: ttYQlc6AMTuVFf-YHHqpdA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6D96107ACF3;
        Tue, 30 Jun 2020 20:32:30 +0000 (UTC)
Received: from carbon (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E977F74191;
        Tue, 30 Jun 2020 20:32:25 +0000 (UTC)
Date:   Tue, 30 Jun 2020 22:32:24 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        brouer@redhat.com
Subject: Re: [PATCH bpf-next] selftests/bpf: test_progs option for listing
 test names
Message-ID: <20200630223224.16fb2377@carbon>
In-Reply-To: <CAEf4BzZ-Ryq+i1ez3Q8G1js6tuD8niAejJzA5Gf7N-vS=6AE_g@mail.gmail.com>
References: <159353162763.912056.3435319848074491018.stgit@firesoul>
        <CAEf4BzZ-Ryq+i1ez3Q8G1js6tuD8niAejJzA5Gf7N-vS=6AE_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 30 Jun 2020 08:46:01 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > @@ -688,9 +700,17 @@ int main(int argc, char **argv)
> >                         cleanup_cgroup_environment();
> >         }
> >         stdio_restore();
> > +
> > +       if (env.list_test_names) {
> > +               if (env.succ_cnt == 0)
> > +                       env.fail_cnt = 1;
> > +               goto out;
> > +       }
> > +  
> 
> Why failure if no test matched? Is that to catch bugs in whitelisting?

I would not call it catch bugs, but sort of.  The purpose is to know if
requested test is valid.  This can be used to e.g. run through all the
tests numbers, and stopping when a test number (-n) is no-longer valid,
by using this shell exit value as a test, like:

 n=1;
 while [ $(./test_progs --list -n $n) ] ; do \
   echo "./test_progs -n $n" ; n=$(( n+1 )); \
 done

Notice that this features that be used for looking up a test number,
and returning a testname, which was the original request from CI.  I
choose this implementation as it more generic and generally useful.

 $ ./test_progs --list -n 89
 xdp_adjust_tail


-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

