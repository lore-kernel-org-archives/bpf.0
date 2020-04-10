Return-Path: <SRS0=/MlC=52=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2173BC2D0EC
	for <bpf@archiver.kernel.org>; Fri, 10 Apr 2020 03:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23E020769
	for <bpf@archiver.kernel.org>; Fri, 10 Apr 2020 03:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXKCsV/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDJDW1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:22:27 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54641 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgDJDW1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Apr 2020 23:22:27 -0400
Received: by mail-pj1-f66.google.com with SMTP id np9so309356pjb.4;
        Thu, 09 Apr 2020 20:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5ty9j/7j67mGeEuCmuzKcLoIOQCULKdAJ/5lUIX2qjs=;
        b=kXKCsV/Kc+2q5+UAsM2dqNzq/4VlceCfswGQjxhYcfZ6XSbVE8NpT6wIymvAFr1t39
         ZYbtWpLdJxenihytJaxAdygV1raleyBvcYrQDwhX/qQiRSAmGs/yN2TsICtWMYXqnOe/
         i+XoAKPzSbwMXv2DBxrpib4yJHguD3afjcSgGy47OtNfUXLY81xEtFOwJB+e0B+9Hx+P
         0amOPRURbGEC3kse+FOHFgsP45KnWq/mb5KCrEmUUuJhCb5Fu+qyYYnQmdccXpefyAfG
         OK3srPvyIn9pzbW4vjeNKFJijmk5edRs4tVcBCG8gWCrdVsOn4jlOWSg6gpwwTmG777/
         lYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ty9j/7j67mGeEuCmuzKcLoIOQCULKdAJ/5lUIX2qjs=;
        b=f/CJwQbDTiycX4GJl1HDawyvtIedOkPvIuK30hr0sImZ4rWpyvygPq/C3+c7EL85s3
         pdtU+QDVrzo6ddhIcvwOLh9V8FNj/aIq0RDWha0wow5QrgCgDZcGa+YS30N3BlknwTmi
         EtTxa5eOmFRJWlRkINDBZZD7CXZsZVrxRAvVzN9PIbb+RMWndCzSrdH92QSMTYdm7X/u
         LqGmYm9YXWKwG+B5Mn1xFt35LPF9os3v23Uv+a83M3F11XAmP5m6hGwQAcBYcZKt3+pM
         27HuBJntRoCi6UigW4xFnHcTx+J8oAPWrI4xy+7Y2PHdatBwrtkbVBIgNX7izAxBVAc+
         QFQQ==
X-Gm-Message-State: AGi0PuY3I0kMqhFjecoytS8+vYPGBpnzaGB48JV666I4dVQITEfUcVGA
        BgJfgrus5tTXkPLyJnNZ4J0=
X-Google-Smtp-Source: APiQypKh3wCowcgVC9+b3wPsd+mLptdY5azy4Py2Fk6KiuoFp3poWv2lrVcGMHKnbUM4WzPckGoWfw==
X-Received: by 2002:a17:902:d20d:: with SMTP id t13mr2729358ply.85.1586488947003;
        Thu, 09 Apr 2020 20:22:27 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:f219])
        by smtp.gmail.com with ESMTPSA id 75sm497702pfw.145.2020.04.09.20.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 20:22:26 -0700 (PDT)
Date:   Thu, 9 Apr 2020 20:22:23 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [RFC PATCH bpf-next 08/16] bpf: add task and task/file targets
Message-ID: <20200410032223.esp46oxtpegextxn@ast-mbp.dhcp.thefacebook.com>
References: <20200408232520.2675265-1-yhs@fb.com>
 <20200408232529.2676060-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408232529.2676060-1-yhs@fb.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 08, 2020 at 04:25:29PM -0700, Yonghong Song wrote:
> +
> +	spin_lock(&files->file_lock);
> +	for (; sfd < files_fdtable(files)->max_fds; sfd++) {
> +		struct file *f;
> +
> +		f = fcheck_files(files, sfd);
> +		if (!f)
> +			continue;
> +
> +		*fd = sfd;
> +		get_file(f);
> +		spin_unlock(&files->file_lock);
> +		return f;
> +	}
> +
> +	/* the current task is done, go to the next task */
> +	spin_unlock(&files->file_lock);
> +	put_files_struct(files);

I think spin_lock is unnecessary.
It's similarly unnecessary in bpf_task_fd_query().
Take a look at proc_readfd_common() in fs/proc/fd.c.
It only needs rcu_read_lock() to iterate fd array.
