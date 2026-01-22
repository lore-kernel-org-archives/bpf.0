Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CBA2EC0B4
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769125658; cv=pass; b=HJo4jTF3vayklhQ/5XAw5lGue0PvcQcHECMOLYDrSHdugz8cTomB2nMWxb7x25UzvDhuaH93Sl3bS6XEqyqo6yebG/ETWpnl7u2nO5ZQicBZxszXE8P5ysd5kLNQEXZS65LLqgD/61WbAdCmr3djD6/vJ/hDD96wQnLYJJwHa6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769125658; c=relaxed/simple;
	bh=qwmyIiLgeAe43ovt87N8hkMHaRAHSuT8MsxDwLWEMVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1nTzU4a9+aaumRv6nnHAuwy8fHoVyFWTcaJa/HOm+XDCoRSlUuvBNsawLvRLDIXQJEYDAuk5NmqfFPIDolJuYO7VR0sQPyS7a+LP2jUVdBy3akAyDJ+pFTy5GLQAfJvBGM59Y7XJIkiJ8wLXflmrsIEr7kQqFYTSvskyB1905k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8O55wXR; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8O55wXR"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78f89501423so26209977b3.1
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 15:47:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769125649; cv=none;
        d=google.com; s=arc-20240605;
        b=SgLcWNCvx6NToPH2NPdwgLvjM/GEeQvusnkVOMH6aPqA87zD99uRzEoh29Blr3vuo8
         AGCit3Fy9bXbFaL6VnhtPl6zuaa/v7Saq7iAg5ZBckganXou1aYFEsoQwWie3G757+dM
         dlfanRpWyTNwT9ObPaZeI3qZY7Kin9iwKqu0/Z0uImap3YLLLAE3cOfQnmf/JcTynINN
         Vi8dY2HzdTKoqPAeIwKJz8RCa2+3zkGTccwVLqE6f4aS7EwMCA+q790vtO1HU787ntzY
         0heBb2py8/ChxB8Z/NsxdU1OUW72TRPvg4V0xlVLiFckRHfm7HRQ+FLGrx5EV1nHVSjc
         eftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4NGvnjqR2QbjD3iS4flpMRdY3JJMrU6qEWBb+bNGr2Y=;
        fh=4KubPJPm/oify4h8BPjn9mdYAYp9R/C82vTyHZeZ5Mg=;
        b=UMRv29gvgZSLlBK9N9A4X8eHWGDo4wKRI13YiSeNeReXEtMlPVS06Lh0YZDIi2vNJK
         +KYyB86UiImgL5tZLZJ4y0qzdL0jHA5Zlm+ZYku+N5pXfgHG/CYiMg3wPWjeJIPKVQ/0
         u/IZIv6sBb+NxgbS/mpzfUZWWKWBIEpM4JrdjdoL8SW4K6SQn8l/X1jyvtttgD4y+9/x
         e/YirSIKHYCUvrPXXKmdEbLO/nk60FHGbphcip4SjdxfLPWoiPjLgMyNu7kZ6JHEmAiQ
         FU7gsK3d9FhRY64PfeLRQVzEVuBrY3xdNTshebSDzZsEKEvI+vRSnUkO8wot/8/Y2jNy
         gR4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769125649; x=1769730449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NGvnjqR2QbjD3iS4flpMRdY3JJMrU6qEWBb+bNGr2Y=;
        b=U8O55wXRcpawwy311eYZZ6oR05K+6mpa3bxRnDGogz95QPygILFDG/PPb6PxNtClSW
         RwRIXGmSQb6n9HauA0PMH/hHPFl2hnqDa2jk1du+RTVOZ5ftlkaESOgvjPhi4aid6T+J
         s7DU4zUpxp8b+Z8iRBPpdIhFIzxHue+C1ujkSKBi/54kOYQiqE0BB+RmnFpxj2lrG+Ji
         pmS8U4C8Qtng5BxTUbP11wDO2yhq6Mq0057UDrkD8l7SuNKZaVoeH1O5wLmdW3093uLk
         bAx+yKbszb4Ikm9/Zye3Mt4YRPBPvhNDuLUc5YSzxFQA3Xt3IM4MmN/6YC5TWEHfl/0j
         0a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769125649; x=1769730449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4NGvnjqR2QbjD3iS4flpMRdY3JJMrU6qEWBb+bNGr2Y=;
        b=bxIj+/KOngKcXmeQBIgmFSDWRUPabDNiMnqvvAjxwUHT0FOXtexyEu8gwjQhVRtT3l
         2SyP5njj0fLa0e0DdQTnfvToGuehV67RVS3sJTm6HHlg013KLECTDp+CQhBUbN5WJxAk
         v6eAJ+RTzk6dvzk/ED0ZnsHTuFlyHN4Nbt2tlAfnVeNA2iyYhJjzQcJM/Gj0a5Eeu78y
         VR2Ii35OOHl8Jf2lgbOjc6NfByORkEyv07Rh/rJjJwHQHI5U9ED0Akhldhw+xlM7je7X
         0XHKYxJzbyp/7L76TFN1od+BT0uNsLJEK3RCiXegIZXPiPuZ5hlBwFk3PZFuqEx/6SFV
         OuMQ==
X-Gm-Message-State: AOJu0Yxl4hy2sYKL83pLIWt4oQubsIsFIDpz79f2qABQamD0raupnfAU
	wNqeyhpnFzi5+mrhWq7bz/vEgi26LDrk7CPrwqNHs1YgqK4DXBq+jIi0a1TJjtpOHNMMuD3f3wZ
	YZH2uJGvSGmp6ThB/1I0zRegAB/UC8Vk=
X-Gm-Gg: AZuq6aKMqBGKQnf7CH2AZ38ry/AEUz2oknKPQ1m5F73C3MIYtLba23QYeYkkjcM89w7
	6DYLiZH8a5YhdvWHSJ26eR5haYqxXyNz+OFp8mK9aMCvNBc8tIy8/d0rCeVVVsjITzbiZW7kTJ+
	nVDGBhr0fJFZopJ5wZ995gnZwi6DanwLO7YNniDLSkIU+v6fGO4Ye8VjExoUpIz7oDAhHg0t3Kb
	3Wh+QzIa9CbJ21lcB7X1TLTUaeJ4pJAUifjvltmj/vB0vBZPO9Z1spwL4wNYp9FeJCEF35LAKAy
	7LtRMQ896yg=
X-Received: by 2002:a05:690e:4184:b0:644:5166:3065 with SMTP id
 956f58d0204a3-6495bf78d17mr914944d50.21.1769125649019; Thu, 22 Jan 2026
 15:47:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122162616.3578898-1-yonghong.song@linux.dev>
 <CAMB2axPhNZXj86cby+4mgBFsVCzk4TnX=aC7PROkTd6Shh_sxA@mail.gmail.com> <3e2fbe5f-d28a-447c-9733-32091f461454@linux.dev>
In-Reply-To: <3e2fbe5f-d28a-447c-9733-32091f461454@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 22 Jan 2026 15:47:18 -0800
X-Gm-Features: AZwV_QjqdwTI_poK6ghnYBJ0stgCKzezFe0iGykNZJ8N5qLVGoP74Lavz4DKDoY
Message-ID: <CAMB2axMiOHCw3p6WFhF14JbKY98OKpa2SjjPRkpcN=T7a5bnjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Fix task_local_data
 failure with 64K page
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 2:58=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 1/22/26 1:49 PM, Amery Hung wrote:
> > On Thu, Jan 22, 2026 at 8:54=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> On arm64 systems with 64K pages, the selftest task_local_data has the =
following
> >> failures:
> >>    ...
> >>    test_task_local_data_basic:PASS:tld_create_key 0 nsec
> >>    test_task_local_data_basic:FAIL:tld_create_key unexpected tld_creat=
e_key: actual 0 !=3D expected -28
> >>    ...
> >>    test_task_local_data_basic_thread:PASS:run task_main 0 nsec
> >>    test_task_local_data_basic_thread:FAIL:task_main retval unexpected =
error: 2 (errno 0)
> >>    test_task_local_data_basic_thread:FAIL:tld_get_data value0 unexpect=
ed tld_get_data value0: actual 0 !=3D expected 6268
> >>    ...
> >>    #447/1   task_local_data/task_local_data_basic:FAIL
> >>    ...
> >>    #447/2   task_local_data/task_local_data_race:FAIL
> >>    #447     task_local_data:FAIL
> >>
> >> When TLD_DYN_DATA_SIZE is 64K page size, for
> >>    struct tld_meta_u {
> >>         _Atomic __u8 cnt;
> >>         __u16 size;
> >>          struct tld_metadata metadata[];
> >>    };
> >> fields 'cnt' and 'size' would overflow. For example,
> >> for 4K page, 'cnt' will be 4096/64 =3D 64. But for 64K page,
> >> 'cnt' will be 65536/64 =3D 1024 and 'cnt' is not enough for 1024.
> >> For field 'size', it is okay for value 4K, but it is not enough
> >> for 64K as maximum 'size' value is '64K - 1'.
> >>
> >> To accommodate 64K page, '_Atomic __u8 cnt' becomes '_Atomic __u16 cnt=
'
> >> and '__u16 size' becomes '__u32 size'. A few other places are adjusted
> >> accordingly.
> >>
> >> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> >> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> >> Cc: Amery Hung <ameryhung@gmail.com>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   tools/testing/selftests/bpf/prog_tests/task_local_data.h    | 6 +++-=
--
> >>   .../testing/selftests/bpf/prog_tests/test_task_local_data.c | 2 +-
> >>   tools/testing/selftests/bpf/progs/task_local_data.bpf.h     | 4 ++--
> >>   3 files changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h =
b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> >> index 2de38776a2d4..4c38f9a7bc90 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> >> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> >> @@ -94,8 +94,8 @@ struct tld_metadata {
> >>   };
> >>
> >>   struct tld_meta_u {
> >> -       _Atomic __u8 cnt;
> >> -       __u16 size;
> >> +       _Atomic __u16 cnt;
> >> +       __u32 size;
> > Agree cnt should be __u16.
> >
> > size can remain to be __u16 as maximum data size is page_size - 8
> > byte. The 8 byte is tld_data_u->start recording thread-specific offset
> > of data in a page.
>
> In test_task_local_data.c, I made the change like below
>     #define TLD_DYN_DATA_SIZE getpagesize()
> so TLD_DYN_DATA_SIZE will be 64K for 64K page.
>
> In function __tld_init_meta_p(), we have
>    meta->size =3D TLD_DYN_DATA_SIZE;
>
> So size needs to be 32 bit in order to hold the value 0x10000.
>
> Are you saying
>      #define TLD_DYN_DATA_SIZE getpagesize()
> is not correct?
> The previous one is
>      #define TLD_DYN_DATA_SIZE 4096
> for 4K page system. For 64K, I naturally tried
> to replace the above 4096 with getpagesize().
> Did I miss anything?

It should be getpagesize() - 8 to be more precise, but that does not
matter to the user.

We currently do not do a sanity check on TLD_DYN_DATA_SIZE, but the
check in __tld_create_key() will make sure data cannot exceed
page_size - 8 byte:

if (off + TLD_ROUND_UP(size, 8) > TLD_PAGE_SIZE - sizeof(struct tld_data_u)=
)
        return (tld_key_t){-E2BIG};

TLD_DYN_DATA_SIZE in the common use case should be small or even zero
if all tld is known at compile time (i.e., declared with
TLD_DEFINE_KEY) to avoid memory wastage.

>
> >
> >>          struct tld_metadata metadata[];
> >>   };
> >>
> >> @@ -217,7 +217,7 @@ static int __tld_init_data_p(int map_fd)
> >>   static tld_key_t __tld_create_key(const char *name, size_t size, boo=
l dyn_data)
> >>   {
> >>          int err, i, sz, off =3D 0;
> >> -       __u8 cnt;
> >> +       __u16 cnt;
> >>
> >>          if (!TLD_READ_ONCE(tld_meta_p)) {
> >>                  err =3D __tld_init_meta_p();
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_da=
ta.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> >> index 9fd6306b455c..cc4d49222d9d 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
> >> @@ -4,7 +4,7 @@
> >>   #include <test_progs.h>
> >>
> >>   #define TLD_FREE_DATA_ON_THREAD_EXIT
> >> -#define TLD_DYN_DATA_SIZE 4096
> >> +#define TLD_DYN_DATA_SIZE getpagesize()
> >>   #include "task_local_data.h"
> >>
> >>   struct test_tld_struct {
> >> diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b=
/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> >> index 432fff2af844..e13f239b46b0 100644
> >> --- a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> >> +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> >> @@ -80,8 +80,8 @@ struct tld_metadata {
> >>   };
> >>
> >>   struct tld_meta_u {
> >> -       __u8 cnt;
> >> -       __u16 size;
> >> +       __u16 cnt;
> >> +       __u32 size;
> > Same here. We can keep __u16 size.
> >
> >>          struct tld_metadata metadata[TLD_MAX_DATA_CNT];
> >>   };
> >>
> >> --
> >> 2.47.3
> >>
> >>
>
