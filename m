Return-Path: <SRS0=dKsF=3G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6028CC33C9E
	for <bpf@archiver.kernel.org>; Fri, 17 Jan 2020 17:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366E42072B
	for <bpf@archiver.kernel.org>; Fri, 17 Jan 2020 17:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtfBp0an"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgAQR7P (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:59:15 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44227 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgAQR7O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jan 2020 12:59:14 -0500
Received: by mail-qk1-f193.google.com with SMTP id w127so23482652qkb.11
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2020 09:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5cGw8JTgwtzajQUHbgFc2d+oU0Cah3x2GwqH42ikzA=;
        b=vtfBp0anBwWxPfqiU2pIRD3NArSsoD+qv28x0JODt9JXAktdwN6W7yRP9YNNUFHM+g
         J9ZrZ5JVtFhIRCj8Q6mevoslC+XfdsJjCDQLITSQ6UwPUM9QlCdrq4gqQbCpU91bMy3p
         ucK7jyIbs3fhs0wesm/QjYWx6flWlYC4AVoNxX1Xg3v2Gc6FGyNM+0rRPdKRkJmIK34+
         3pvnIu9kk6KXMJlGuCa6lBYSLbXt2wVFYivgFsGSO+elmIlkxEjQQsllF1ShlXwnRn7u
         2rjDskEbJ/wr5vRZgomKDHtV17HOSoOP0VEcm48/ADlpbQXk/qugwDlzL6TUddJhs4Ms
         HS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5cGw8JTgwtzajQUHbgFc2d+oU0Cah3x2GwqH42ikzA=;
        b=b61Udbf/234meAcvFcoXITOrpamuhcgU3ULelC1VtI7NdaYc/ELBSDEumlK8dMvRRE
         iO/gtrxFbCKok8meJjG2qO6xnT1CM69zse4RIKeG3TuemYOjPkBRO1IeZWcgn93qGtE6
         p5OFJj3aYNWfh/x4ZHLyNC6M/OagM5uog56xYH03J7lwxnKq1O1UMxFkVh+lQ0DGEsdz
         dYiCxmDPbFJwdKZgodXoUJTmUuld67l6EE9U4ZXhQhAphhEK5uiboRTTaPnRbbpdLnon
         JQqIRFw/mwzK5JpITpN2q71xNaC0nDVgiA2i+mujLq6o7d2NkC6CEL1EXvLTM0I+G0Dd
         gTIQ==
X-Gm-Message-State: APjAAAWHXMyh39ewuGr5CP+N9YSBn9Xch/kbvBhMrWctw8GHx7zAbeqe
        TZLcu4AN9ToDbLuW0FyUxiZ0QuZ2mP3tBlxhrIU1Z/5Ojp53ew==
X-Google-Smtp-Source: APXvYqwXRDUlwJRcB2H9LoRkuFRAZcHzyT1TRq/qfmp1keSsF7jbgngh5ZNPzrUwLbHANWqRscOI6pr6DFKuDlHvOFE=
X-Received: by 2002:a05:620a:1010:: with SMTP id z16mr35130151qkj.237.1579283953316;
 Fri, 17 Jan 2020 09:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20200117104400.iwfowq7z4epdvoww@kili.mountain>
In-Reply-To: <20200117104400.iwfowq7z4epdvoww@kili.mountain>
From:   Brian Vazquez <brianvv@google.com>
Date:   Fri, 17 Jan 2020 09:59:02 -0800
Message-ID: <CAMzD94ShnYFL_n0XseKt3XbX2yQF+3LPZuM2w--MTqXDxmXECw@mail.gmail.com>
Subject: Re: [bug report] bpf: Add generic support for update and delete batch ops
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 17, 2020 at 2:44 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Brian Vazquez,
>
> The patch aa2e93b8e58e: "bpf: Add generic support for update and
> delete batch ops" from Jan 15, 2020, leads to the following static
> checker warning:
>
>         kernel/bpf/syscall.c:1322 generic_map_update_batch()
>         error: 'key' dereferencing possible ERR_PTR()
>
> kernel/bpf/syscall.c
>   1296
>   1297          value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
>   1298          if (!value)
>   1299                  return -ENOMEM;
>   1300
>   1301          for (cp = 0; cp < max_count; cp++) {
>   1302                  key = __bpf_copy_key(keys + cp * map->key_size, map->key_size);
>   1303                  if (IS_ERR(key)) {
>   1304                          err = PTR_ERR(key);
>   1305                          break;
>                                 ^^^^^
> This will Oops.
>
>   1306                  }
>   1307                  err = -EFAULT;
>   1308                  if (copy_from_user(value, values + cp * value_size, value_size))
>   1309                          break;
>   1310
>   1311                  err = bpf_map_update_value(map, f, key, value,
>   1312                                             attr->batch.elem_flags);
>   1313
>   1314                  if (err)
>   1315                          break;
>
> But the success path seems to leak.  Anyway, either we free the last
> successful key or we are leaking so this doesn't seem workable.  Does
> map->key_size change?  Maybe move the allocation from __bpf_copy_key()
> to before the start of the loop.

Thanks for the report, you're right that part is buggy. The allocation
should happen before the loop, and we can do copy_from_user for the
key. I also see the leaking in generic_map_delete_batch, will send the
fixes shortly.

>
>   1316          }
>   1317
>   1318          if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
>   1319                  err = -EFAULT;
>   1320
>   1321          kfree(value);
>   1322          kfree(key);
>   1323          return err;
>   1324  }
>
> regards,
> dan carpenter
