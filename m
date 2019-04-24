Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0386C10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 21:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CED020835
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 21:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5Ge14SE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbfDXVCL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:02:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36765 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbfDXVCK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 17:02:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id y22so140138oto.3
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 14:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3MEziRvFO2hfDyEPhx9UhGl15e/Zvrg+as+Ky69tuc=;
        b=H5Ge14SE6RlKf+bcz4qOMigS5XwXzCvxKaV8J4SDmGOTMoG3UEnvyiFcTNQydHHzW8
         seNrHdaPcE9A3nfvceqKYXJGC0iiEMmm+aSi+Cg7vYSgfoYXajSAG/HUvM0xDuwTaCA0
         oXHZJkmgVrpeQyWKAdC0g2I9RuFArWC5KQa2EjmY3acBOCEg6xZiTBD4YftqRuE+RfvT
         17KfuVxWPvbUwo42lsdWueLgRnwKtIhgUamoMBxWegpJDJLMH031o42cp0RjlLmUu3uZ
         KBRj9m+TMEi8LWyb2rAhBsutgXkGBfcQ6maf+GMwVBveK5WQOxy28QclkSKbiwmMiSTi
         iaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3MEziRvFO2hfDyEPhx9UhGl15e/Zvrg+as+Ky69tuc=;
        b=ukyFF0U2sk6qeKaQc4z+btKWz8w4zNur9oHG38bHEPpvOYkdbaOjuqOcGs5DcUzecf
         x0d864vmuu/4MlAr61kJu/0IBXU+9hestKHaKwV7b4P2YqknRZOW5nKFGaxCcz5v8OjF
         V6QLE7vrhBmGU/GdR2pwqGrh1I/VOiZLfs4CLE3WineoPPHnttAljfRaUFo3FFEd0p+U
         9aeJcf2y5dVUj0RySA9DcmexJ6D21HwtD47K2DRHY3Az14/+OeO5LA/b1ezUWiyPB4/o
         qG/WGrurYfY6hPg/t3jFICNU/AJbuT7Bbwgk4Woxywa1d2FWdhy09ryJplVqVHXb+plc
         AEsg==
X-Gm-Message-State: APjAAAWC/uArncC1UqFmuFNWHohwkgYF3jfbiTyu5FQHs9NOXaukuAGy
        bjkVVCSoRABfFF2s6mU+MTrIei6b89YNjxE7YfvyUzgBhDg=
X-Google-Smtp-Source: APXvYqyAF0wBl9FEN5ZQ1A3B+y3Bu/TfOl83ZPw0Y5/AkZSnDLoYOYCmk5tuzps61ZOpFgsJLoWCgevxKJED3GOywhk=
X-Received: by 2002:a9d:74cd:: with SMTP id a13mr5632885otl.73.1556139729943;
 Wed, 24 Apr 2019 14:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190424160951.45865-1-sdf@google.com>
In-Reply-To: <20190424160951.45865-1-sdf@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 24 Apr 2019 23:01:43 +0200
Message-ID: <CAG48ez1aEenkwonZ2UXFOE46kdPWhsiOMNory4gQgK9J5kz1ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: support BPF_PROG_QUERY for
 BPF_FLOW_DISSECTOR attach_type
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Network Development <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        jakub.kicinski@netronome.com, quentin.monnet@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 24, 2019 at 6:09 PM Stanislav Fomichev <sdf@google.com> wrote:
> target_fd is target namespace. If there is a flow dissector BPF program
> attached to that namespace, its (single) id is returned.
>
> v2:
> * don't sleep in rcu critical section (Jakub Kicinski)
> * check input prog_cnt (exit early)
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
[...]
> +int skb_flow_dissector_prog_query(const union bpf_attr *attr,
> +                                 union bpf_attr __user *uattr)
> +{
[...]
> +       net = get_net_ns_by_fd(attr->query.target_fd);
> +       if (IS_ERR(net))
> +               return PTR_ERR(net);

At this point, you're holding a refcounted reference to `net`. It
looks like that reference is never dropped?

> +
> +       rcu_read_lock();
> +       attached = rcu_dereference(net->flow_dissector_prog);
> +       if (attached) {
> +               prog_cnt = 1;
> +               prog_id = attached->aux->id;
> +       }
> +       rcu_read_unlock();
> +
> +       if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)))
> +               return -EFAULT;
[...]
> +}
