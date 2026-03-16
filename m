Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4563E5EDE
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689164; cv=none; b=VbUd8vPktFfBaLqUI4Kn1wg9IW17Oh+w2CRDi8PS2CL6VOYdoBNdtApsECgmbG+b/TbfS5XAxSEBIM1BnjTXwCWpYo5sZn0VNtvY1FzJPRixetWdtrG+dcW8cIZE1Gs21qZ+PR0crhVxYZ7/1s7xUeFrxtubp3VJ4CkPnrsiLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689164; c=relaxed/simple;
	bh=VVODvYdVPAPnIMUtIejNvVcYb3+5h5t9au0lrAORh/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BKOuZP6AAtEiwpmAVU7y26/EsGcg+jJdEu2jPze+Ks7j9uUeQhcQZJilhr/MLbKkPLfC7EpekTNxGtjbCb0Z6FpqljWO+gKvIQI6YQF+tyS1Uy6xK6OMt8n1vlHoyL6PGbRdEZTgLYGrdPTm/3X+TVzyJgQaeJ9boSMWAPtUA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xkdrta7w; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xkdrta7w"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1271195d2a7so610191c88.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 12:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773689162; x=1774293962; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6cMzhf4VkTVYDmEHyBOjOEPI5+8JmDa90f9gmIiMY64=;
        b=Xkdrta7w2/wGw0vEMzC8P8XFNgSo5H93Izh9TjzA2eFgYkinFQfoabvVoF32k9C41P
         W0UqQgd/agzbeMsjBEYmpBE5ie/sQDw6xJIA9StZ9apLLrkdg7rriLgaa9UVRhwox5SG
         jO48t4VetrVNy4cOUZ3H35eVBSaPH5j19+qVINMQnmJUbi/JfpziVKmhUcmzf0+iULBw
         wnor3DNdq5sVkdoGH6fwBFnodUYT09vlEc6Iz0XGu3gtpZc57aNFO1MX/3Wk7aCG+Of+
         FsEFYk+QjsPRPlNyfzl0EmIIAzxPppFEJ7/+aR2Oo7N9O/Oz50z4cBCsUNS4sz1+Ra8V
         Fm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773689162; x=1774293962;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cMzhf4VkTVYDmEHyBOjOEPI5+8JmDa90f9gmIiMY64=;
        b=Fc0VypVdIsEL2aRr0tlMzNiUyJPMMt5zSuBXWasAqBgeR5DuL5LtsgVYLGXqxYTgis
         1NJt5iZnVzQfgr8AB4vlMIQEPEAsVxtGG9qhc5VHZT9G5FcslUcKV4ydSEYQ2xbMtqS9
         zCmdNH3bYDi45TvWe3Qy9xhjWdORZ4EODCMu3BCzcU/6uKeSkeciLPdGJiW4QT0sjKJ+
         8+QvA1WWrQimWjxYSnjRW+Fi2uxv8pxEEp2HoMkRRIvh9GHCEmlLwScGoxQ0ZQ+Bwpxk
         gLvuhCByPsNoyq9z6KNuomfgBWm+5BbuzozWgONPuigFiNlJQE9UX8xbOrKFKgczf9R7
         2lVg==
X-Forwarded-Encrypted: i=1; AJvYcCUpUCKwNdi3axCyfD/D4fQeesJ4fP/eg8YtquMi41tT+nAJ3LMvMuzMfnBSxYazeeCb7tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBehU39BAlkP5ewQYUbE1JyHTcWGAia1Ou2/QJ4jwo+8Cnt1FR
	FKLpmunVKpQVqF/P4aU25Pyv4pz7MRxitCCshTTqcnPPUYlOmdyzx3kL
X-Gm-Gg: ATEYQzyZ5s6zWA8W7d9pWPyuTGGxDflR4YUbJbogusOGstUZ4MCn6gSvFJqkJaLIzli
	clA2BOdDWHpUDUg6SwkXQiZEi3GBX9Jkt+CCs7F3/HguJHJRZC87iiqiB++rjT+hGc8+lbDT9cE
	AwAz2r93PhKg4bJwMh5KO0uEgyAL2rRBXit4aMMimApTfOk2bomxo1OY7SGLhN0+QEDiDCGXjje
	eB+8EtLmR2FdJyYjIJRLoS/KJm/nHhIsh7wHHVx4lnLsLJaKHemfE3JBzjqLhptVcptyfDIK5bo
	r/FX6pfS6tb+j2vcDh/ZRpKOa5rOIKGnSHLZIQXO7wymzVMhTcpEi1eIrYLwr6U8p86vMqCF/Le
	FAgPq7LpSyg36vkoUI9ctWLqnsUQo4nyLaK1v5J1G/RziVQ/tVpg+d/OYnxmmqN9C19093mwnb3
	e24pqkrWybS90Lgh+KcPkuGqIRIpo1hiuqyEVviy4xF+6TXtb6ltOASozMZM0=
X-Received: by 2002:a05:7022:6b94:b0:11b:9386:a3be with SMTP id a92af1059eb24-128f3e2a387mr7005017c88.41.1773689161705;
        Mon, 16 Mar 2026 12:26:01 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::7bc? ([2620:10d:c090:600::76f6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab55541fsm19113857eec.24.2026.03.16.12.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 12:26:01 -0700 (PDT)
Message-ID: <430af20f8bdeb4965e7367578e0795d4eb006504.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 09/11] selftests/bpf: Test using dynptr
 after freeing the underlying object
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com
Date: Mon, 16 Mar 2026 12:25:59 -0700
In-Reply-To: <20260307064439.3247440-10-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
	 <20260307064439.3247440-10-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-06 at 22:44 -0800, Amery Hung wrote:

[...]

> @@ -223,6 +253,12 @@ void test_ns_bpf_qdisc(void)
>  		test_qdisc_attach_to_non_root();
>  	if (test__start_subtest("incompl_ops"))
>  		test_incompl_ops();
> +	if (test__start_subtest("invalid_dynptr"))
> +		test_invalid_dynptr();
> +	if (test__start_subtest("invalid_dynptr_slice"))
> +		test_invalid_dynptr_slice();
> +	if (test__start_subtest("invalid_dynptr_cross_frame"))
> +		test_invalid_dynptr_cross_frame();
>  }

Nit:

maybe consider using test_loader.c based infrastructure for failure tests?
E.g. like below:

    +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
    @@ -115,6 +115,7 @@
     #include "verifier_lsm.skel.h"
     #include "verifier_jit_inline.skel.h"
     #include "irq.skel.h"
    +#include "bpf_qdisc_fail__invalid_dynptr.skel.h"
    =20
     #define MAX_ENTRIES 11
    =20
    @@ -259,6 +260,7 @@ void test_verifier_lsm(void)                  { RUN=
(verifier_lsm); }
     void test_irq(void)			      { RUN(irq); }
     void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
     void test_verifier_jit_inline(void)               { RUN(verifier_jit_i=
nline); }
    +void test_bpf_qdisc_fail__invalid_dynptr(void) { RUN(bpf_qdisc_fail__i=
nvalid_dynptr); }
    =20
     static int init_test_val_map(struct bpf_object *obj, char *map_name)
     {
    diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_=
dynptr.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr=
.c
    index 2e76470bc261..f085872c3900 100644
    --- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.=
c
    +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.=
c
    @@ -3,12 +3,14 @@
     #include <vmlinux.h>
     #include "bpf_experimental.h"
     #include "bpf_qdisc_common.h"
    +#include "bpf_misc.h"
    =20
     char _license[] SEC("license") =3D "GPL";
    =20
     int proto;
    =20
     SEC("struct_ops")
    +__failure
     int BPF_PROG(bpf_qdisc_test_enqueue, struct sk_buff *skb, struct Qdisc=
 *sch,
     	     struct bpf_sk_buff_ptr *to_free)
     {

For tests that exercise verifier failure messages this has some
benefits. E.g. the following command would reliably produce log
output even if program load succeeds:

  ./test_progs -vvv -a bpf_qdisc_fail__invalid_dynptr/bpf_qdisc_test_enqueu=
e

And __msg annotations can be used to force-check the failure reason.

[...]
