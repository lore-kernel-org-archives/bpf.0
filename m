Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058A92C0F84
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539138; cv=pass; b=uwoQMfvQaHyKYay2pmPlAt5LZLw1VVqwuFJeseXPCyk6Kba2kXv3H8+OMIJatlIpp0YhPPuiRoDs0yzGRTwEcQSxRrbn2znj+dPuyMbBoHyL70J9cXOl8kmhvj7zHhcy2L62js0GBvJ12BQRT1VZpm3VYwF4I163xnJUCwiu9us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539138; c=relaxed/simple;
	bh=xfJlsDitPFNINo6PdvW9xIIO5tUhmZ1J+GBfu8WBap4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPmKCU8B/kJwE6k+RenV78GElONQRujTCJedJSFQJOAGdrOJMnp5M6FoXKf5thtl87AmA/lcU7blwHq3MsZH4eThopMvsTpnLyKnh7Q/nEX5NS2Bzxa/LSFV5ijtUnLHeVOnPhJKNqxO2IXOwZCeIfzoaJKxJeGeB3fBPsU5weI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEKhwcxB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlZ5ZX6F; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEKhwcxB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlZ5ZX6F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772539136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4CtqcFVzp3mF5EfycFswotSYwJN7isvCXXnUa2seYY=;
	b=iEKhwcxBNxa7MlUsJzK397tIv1BnG3FjFr+EcTr0zRJe+QNwPgLXOuIlkT75QErvV15xTV
	O0Qltw1dSDZY7q4wAqYqsFSe+WCN+A0OD2RINz177ofbVwqi+0pKCPbyqpyQmynlsOE4OY
	lk3+g+QyRQ8BHbZ+ARExFlGccMydWZU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-T2zUWZGDMvqvd2GrFVc_UA-1; Tue, 03 Mar 2026 06:58:55 -0500
X-MC-Unique: T2zUWZGDMvqvd2GrFVc_UA-1
X-Mimecast-MFC-AGG-ID: T2zUWZGDMvqvd2GrFVc_UA_1772539134
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b936bda5ff3so573177466b.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 03:58:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772539134; cv=none;
        d=google.com; s=arc-20240605;
        b=Zv5WhJXeroCAuLQ89B6hsGzsxr5hIDI8JqwLTmVS2sAP1jMIbC4/xdn+GHQynGvIlc
         l6DruBWjx/spTUiSdmUjFsOw7uNCqlulESoNv/maoM+/RAd0J/zzQJ6kLIbUp3ICzycK
         keU6Z7hUtj4DuUFlPKDL+ThuMAed3PwFi3QRmud85iJYJh3O8OGgxK66wh0lmE4ZKyIG
         Rd8cnz+EV3BGCQxLRiX9FBQesvzhAU9Ud+oRCBkX+5ipnrCEPtXE3UyZRhP/hE3kEUJZ
         2YIaa5TDGR1g2lvwoERNcsfnibyD0VfjRwKYZemxQjULc3m6ABPl00fcrsXRif2+1h3d
         Yj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o4CtqcFVzp3mF5EfycFswotSYwJN7isvCXXnUa2seYY=;
        fh=I7g8BM5J4zGDS3MYd1saLRbuOIqoVEHTjhLlXS02hnc=;
        b=Xxw5Hxt7SNVYXrZmCDL8byw96ybnsTupVKFsn8pKvUciV0WSXIsicoZC2BiH3TdsuE
         RVloYVyR3SAA4qJB5p7DRiM7u/Ok7TDU4Ar5gXCewG1LyZioIAXHykG8qblMRd4Fz7Pj
         OD2no88NWnwUfePQSWvjeJJ9pcOHIv0VcmLtmBkh9CjpeEOrMONiKq+DV9exyXB21/3T
         0YueYv6RaX9Tzs7sD4DjNHIDqy3kqDBtxSk8rwdHMXq+ykssK1XxSIDzuR6ftQM4zt+G
         Zj4dra8xIvd1Vb+GIFcxUrMVBKivODdnQQZZOKqbnreF2AJN3hai25313+IRiWvvGu+Q
         XQig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772539134; x=1773143934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4CtqcFVzp3mF5EfycFswotSYwJN7isvCXXnUa2seYY=;
        b=hlZ5ZX6Fkp9qIRsMco1/ln3C62Pv4Z1QB4hPr2ZPn3mc5kZxCaTS4eUAYoXOcIM8ju
         BCnpE89rYna0lkt/66X7FwC0r7LEYfUJtaSyEKvDyXdoWvi2HMkVYQbugU+EF2YOBSaw
         mqX5pXbfwSota1kiDB7jmR3HVtzh/wzyyEn+QN58PN29ixjL2uVQk715sdVRWCaUa5QE
         cqkdNDzOCIIMVdHeS0nwKqNmucpGCx1ig9ElrHiI2HV+9dtfU/owydWmhrgXmJux6u8V
         Pa4KGGgZPbM4BqG16zHqIJi9+8UwqFhSZV6xaL+Hhvnh4T4IxsZC689Erw3xEDlxNZ0c
         447g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772539134; x=1773143934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o4CtqcFVzp3mF5EfycFswotSYwJN7isvCXXnUa2seYY=;
        b=vPFeI/EmpjQuB3Vcr0+9xcUJ3q55cTd5DxK0HA9AVaWF/OvRrv0jje/cl7Kh6kgRBy
         M2KB0Za7hfJd1evrC4eNc0hOgG3Yx076YE6na5OWPp1NdWy66op2Nn2B9Mm2SJ1TtsYJ
         V6ZItvG+aESFQFv/ssZxDKeyoeNFG+WJ55Cw3R+LVqOLjFxRk2+RnK1/5UMlfL63Ekux
         bt/PXcngVRwdp2GPuLHLp2HYt7iDmpOhpFuCipLcJ52DgNWUS3ffLjvBd6xpXNWPFSID
         yAKjwx9pxSNlhIc3+SYu6qyZF77y+Shf6+VSubBl5EQl3TqBI6hflqTB+lU5Mp3VWATq
         mEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhgsNHuqsJEyYbf7kICVQiU9BlxhuCNRGKcI53a9eiH6w2fvafKwvAw5jBY1egg1oAXK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGdkK/RhGkeG12EAAN8LQt0x7raQQZIP6aY6QOF5tVHqj3kecc
	8Js9lF4b72EC7xiOUQtuSmiQDZ8iYY0NLXRoQwX+tHHHc49OZHbB2xSSXqz2d0maxY0iDCK1zOE
	pyWMZou7E6n3ML6PQ6Ic5uLWBEkXhYfmPY6Gc92pPhLXKaRzeTfWt4o4jeU+xL8vlycCIp7+6jY
	JexdbS42T29GRvDXlzP6SCTsplMdOm
X-Gm-Gg: ATEYQzwKdpEJu8AjXA/AnpnUC7z/Kodgn1OmcKBGHyb2o8oK15+g9kkqviyFIS0iNNQ
	5Yy3qBFnNhakKaxJ/v4wAGCwzm5uSzWsAPC0ca8zG7H3KeOx1b0c5xe+I0dMkO9e6zsfwSinfa8
	7SdHNI7yTLIaDC8y8+rc017V/H4tTqp+DIQtT13Uc5WN4rOrBpCsMe10zCB5A7+zY9Wyzm36z+C
	P5LcA==
X-Received: by 2002:a17:907:9710:b0:b8f:8cf4:adf9 with SMTP id a640c23a62f3a-b937636b784mr942091466b.6.1772539133652;
        Tue, 03 Mar 2026 03:58:53 -0800 (PST)
X-Received: by 2002:a17:907:9710:b0:b8f:8cf4:adf9 with SMTP id
 a640c23a62f3a-b937636b784mr942088666b.6.1772539133148; Tue, 03 Mar 2026
 03:58:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-4-wander@redhat.com>
In-Reply-To: <20260115163650.118910-4-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 3 Mar 2026 12:58:42 +0100
X-Gm-Features: AaiRm5063jBEqkXltmA3PT-me9_BDiQPgb3Y2Uz23cyuYoxnZQPISFkwvAHn7aA
Message-ID: <CAP4=nvTcKc+=usb0N_Te+dR+1+Zt0d6edaQD+xbyBXq_TC4LQw@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] rtla: Simplify argument parsing
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Haiyong Sun <sunhaiyong@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Daniel Wagner <dwagner@suse.de>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:25 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> The actions_parse() function uses open-coded logic to extract arguments
> from a string. This includes manual length checks and strncmp() calls,
> which can be verbose and error-prone.
>
> To simplify and improve the robustness of argument parsing, introduce a
> new extract_arg() helper macro. This macro extracts the value from a
> "key=3Dvalue" pair, making the code more concise and readable.
>
> Also, introduce STRING_LENGTH() and strncmp_static() macros to
> perform compile-time calculations of string lengths and safer string
> comparisons.
>
> Refactor actions_parse() to use these new helpers, resulting in
> cleaner and more maintainable code.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  tools/tracing/rtla/src/actions.c | 57 +++++++++++++++++++++++---------
>  tools/tracing/rtla/src/utils.h   | 14 ++++++--
>  2 files changed, 54 insertions(+), 17 deletions(-)
>

Suggestion in case you will be sending a v4 of the patchset: the
commit description could be more descriptive, something like,
"rtla/actions: Simplify argument parsing", or "rtla: Simply action
argument parsing", to make it clear this affects *action* arguments,
not command-line argument parsing in general.

> diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/util=
s.h
> index e29c2eb5d569d..8323c999260c2 100644
> --- a/tools/tracing/rtla/src/utils.h
> +++ b/tools/tracing/rtla/src/utils.h
> @@ -14,8 +14,18 @@
>  #define MAX_NICE               20
>  #define MIN_NICE               -19
>
> -#define container_of(ptr, type, member)({                      \
> -       const typeof(((type *)0)->member) *__mptr =3D (ptr);      \

As Crystal pointed out already [1], this part removes container_of,
only to restore it (see below).

[1] https://lore.kernel.org/linux-trace-kernel/301c25518ff81dc967187497a057=
7f8ee2fb2e29.camel@redhat.com/

> +#ifndef ARRAY_SIZE
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
> +#endif
> +
> +/* Calculate string length at compile time (excluding null terminator) *=
/
> +#define STRING_LENGTH(s) (ARRAY_SIZE(s) - sizeof(*(s)))
> +
> +/* Compare string with static string, length determined at compile time =
*/
> +#define strncmp_static(s1, s2) strncmp(s1, s2, ARRAY_SIZE(s2))
> +
> +#define container_of(ptr, type, member)({                              \
> +       const typeof(((type *)0)->member) * __mptr =3D (ptr);            =
 \
>         (type *)((char *)__mptr - offsetof(type, member)) ; })
>

...here, container_of is restored, only with one more tab which is
unnecessary - that is why Git includes it into the diff. If you remove
one tab and update the commit, the change should be dropped.

Otherwise, looks good!

Tomas

