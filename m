Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D03138F945
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455456; cv=none; b=MpdpeQCdokCbAWKr20TEac3xbXrxhvCuZsHcgeBt4gp+oor8pHJk01ow8Xcq12vnEIVdRqUAXXOkRd1wyrBT/WxzPWCNYLPyyDnyNzMI5DAPy5F/751IKBUSJ8hnSoe3FGtwsPAwZvAkBCmxs8Btrdt9KstI+ihgKrnLAsinnZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455456; c=relaxed/simple;
	bh=1clt3i58C/QDMLFXDAkDWFhq6DZ1AfZz9cgjFLXCjXk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=F13AxBpbq5lNW1K/2FT98PJOGst1vi6lcnVpH+ZM3GFxf1Xj2jvbcC517JvRQtTgZimGVr5NYCqZA7GBIA24dqM8NBHffZWY9UruNzSmuj5fgAn7goA8tGrnlf+1Tx0UvnEPlmbp2IXEc9K/r+yNywVCuu22rQsmSFLCkA/+mnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHfN0MzM; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHfN0MzM"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dcd17e19b6so5294524a34.1
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 02:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777455454; x=1778060254; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7eUCe1dsn0MJAzxVCxDFZs7ryb0/th+2c/uLHnZfNw=;
        b=nHfN0MzMfZvxl/Fz4s2c+vvS6u/3wFI1q8Kz0EXuAaiMD1ffEJgSsnL4qDiMWOXBl8
         mdF13OR6qMT41Bn7zn3CPcuz56sFFL8AYFsb60ABA1LzSSkPzmvuIT17Jec8yHKI43KP
         mx5kH9I81xQO0nKfoO3ACMuWI6V0jaeS0Ocwz1v7fCn89uVF3UWPaMo5vs9f0b4rxq+U
         uHUPuFTf0UKQ0s1eDoyvNwmMr+MU9WV7V/uJ4BG9HRUf9c4qUBXlUPDYKgUVLpwCp5qt
         klL+omu7iXA1/0i/Z7ZW1xxnsbvHpVDtC6Nf5gwFa/dgFZwoRVp8AHew+QKtF8vUtcQP
         fa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777455454; x=1778060254;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7eUCe1dsn0MJAzxVCxDFZs7ryb0/th+2c/uLHnZfNw=;
        b=gZOV/9XQnkPjfZOrsOumle2Kks1IbO0NO+gpd/LTPLhkxS45UFIWGNuNWX1MqD1mNf
         jzKX8wzCFhQjCYxEHYjtb2DJTgzqdM0h906/O0+E2sLqheo4PVL8l2oXdSgs62g10wdc
         ZYcUCrOZadPPq+NxAZgRaKCOR3DkbCvSLnlxxXleqlOCAP+f1zfqNLN/U/FiIYFhcIB6
         vP6Y22E7WeMRwmfzHB1/RiClO49LFEdYFBYMUdg5iHJpjCEuViuKT7p/1JD998Lf5D54
         X0TVAv4m1p7iXrkq0nsKhxu45Jqmg0RtVwSLd0+F7gK73OiMy2rwaRV84afVDoT1RsKM
         NZTA==
X-Forwarded-Encrypted: i=1; AFNElJ/xFiWqm4mZ2hbwYF8NuYKX97bkL1Tm+SU4svALzmllVovFtU8mxfJ93/VZWVs5DsJtalo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoiZZ41iL8j+9btliC/dzFI3hZ1cjvkKJ7QzDBXEotl4H1qHEC
	W+LFIBzZcOyRFQkfb2S3IKGNkfNhiZtNWgl00REdu7pIMgCgW8UKEzwW
X-Gm-Gg: AeBDieuAO45G/jI7tjb70Ki7wqha6HXjK0pIwVy1re4MqeO2yB1NWQYrG5upXtr+P8F
	QUAY2mCEg6yezDF3fb9FQHb592Mpex/5qMF2TtPLE1trPscJ4O6v2vcc4jkxFPkg8kGsdkXAayL
	ADtjbOcPaeB3fCYdyTx9dP0Znm0UoG/g6t5bmlgWkAKcvMInyB9+/ltRdySF6BsxFZg4ys7bnqB
	nofn62JepUUF3p4CwoBUiz5MsEy26nIkI9SBrzvo5iV7qroZdTzntmZTCSnOGjG8WXhp4nejUel
	3SxtU6c/gwb8YsuPAnNlRR9cZoa0Il7MI2lTVwaY4hx/wCEFBz4KwvMZYuksnwUqIJsxKKra6D8
	3YWIbpB5c4xD9DW1/RfajakGDuhm0JqL/cSjFsyPhKZfG+PzXxXANsyHkZ1pagjQjbbZ5veMRiI
	ijwz/WcXsSeOJFqKOjvL1BIFrIn2izB+33fAFddH3ektL/Yp44Z2avssKR+qwdakT55tY4T7G79
	i6Hw+tnF8+vy+PMgeotBgD5+SQr
X-Received: by 2002:a05:6830:67ca:b0:7d9:f50f:9693 with SMTP id 46e09a7af769-7de9a0ff24emr3938756a34.23.1777455454381;
        Wed, 29 Apr 2026 02:37:34 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deab9c1858sm1046015a34.19.2026.04.29.02.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 02:37:32 -0700
Message-Id: <DI5JDE24ICIE.1PAT8HWYK9ENS@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Justin Suess" <utilityemal77@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 3/4] bpf: Fix deadlock in kptr dtor in nmi
X-Mailer: aerc
References: <20260428201422.1518903-1-utilityemal77@gmail.com>
 <20260428201422.1518903-4-utilityemal77@gmail.com>
In-Reply-To: <20260428201422.1518903-4-utilityemal77@gmail.com>

On Tue Apr 28, 2026 at 1:14 PM PDT, Justin Suess wrote:
> Defer freeing of referenced kptrs using irq_work queue.
>
> This fixes a deadlock in BPF tracing programs running under NMI.
>
> Each kptr is tagged with an auxiliary data field storing an llist_node
> and a pointer to the object to be freed. These are assembled together
> to form a queue for deletion outside NMI.
>
> Add a field to each data structure capable of holding referenced kptrs
> to store the llist_head, as well as an irq_work struct to the btf kptr
> field to store the task callback.
>
> The llist_nodes are linked in the queue safely, allowing them to be torn
> down once NMI is over.
>
> This irq_work struct is foribly synchronized on btf teardown, enabled by
> the change in btf cleanup code introduced in the previous commit, adding
> the rcu_work teardown.
>
> At dtor time, if the execution is in an nmi context, enqueue the
> referenced kptr nodes in the llist_head and enqueue a job to drain the
> list, calling the respective dtor callback from a safe context.
>
> If running outside nmi, use synchronous dtor path.
>
> This touches arraymap, hashtab, and bpf local storage. It's important to
> note however, that the bpf_local_storage code rejects nmi updates
> already, the code changes in that case are just to accommodate the change=
s
> to the record extending the kptr.
>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Reported-by: Justin Suess <utilityemal77@gmail.com>
> Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal7=
7@gmail.com/
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  include/linux/bpf.h            |  69 ++++++++++++
>  kernel/bpf/arraymap.c          |  36 ++++++-
>  kernel/bpf/bpf_local_storage.c |  13 ++-
>  kernel/bpf/btf.c               |   6 +-
>  kernel/bpf/hashtab.c           | 181 +++++++++++++++++++++++++++----
>  kernel/bpf/syscall.c           | 190 +++++++++++++++++++++++++++++++--
>  6 files changed, 456 insertions(+), 39 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 715b6df9c403..037bdadbed96 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -9,6 +9,8 @@
> =20
>  #include <crypto/sha2.h>
>  #include <linux/workqueue.h>
> +#include <linux/irq_work.h>
> +#include <linux/llist.h>
>  #include <linux/file.h>
>  #include <linux/percpu.h>
>  #include <linux/err.h>
> @@ -234,6 +236,10 @@ struct btf_field_kptr {
>  	 * program-allocated, dtor is NULL,  and __bpf_obj_drop_impl is used
>  	 */
>  	btf_dtor_kfunc_t dtor;
> +	struct irq_work irq_work;
> +	struct llist_head irq_work_items;
> +	struct llist_head free_list;
> +	u32 aux_off;
>  	u32 btf_id;
>  };

This is extreme per-field overhead
500 extra lines to fix a corner case?
That's not what I suggested. Can the whole thing will be
done with _single_ global llist and irq_work? I bet yes.
Think it through and send us prompt for review instead of code.

pw-bot: cr

