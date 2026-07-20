Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9BE43E06D
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564522; cv=none; b=MZRcJGnwjcsmvuqMYkytx+zrnfpQx3FEm6my/1zUv0rOqvji7K+SicLXGLED5lKvMhl5PxPZ5B4SZhmcL287Uggv8pswaEbLylvu1fBS2HZrdj1OH+8ihCb0dNAAeBTKqFavsqUG8CUUGgZhDIviccIBqGVlWtqyHiUCY5IVRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564522; c=relaxed/simple;
	bh=0YdNydfw4xMctPFOfeLTpz+PtcBJNRG0IrIv2owRlhA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=sl1RlbDAfmcG5Ly/FIj3HE4KYNx9fTA3TZp32bO5yfIQCwDODbmJarE7NlOizKdinKmlXZnKWBCMA32TCjniBB13irCoZXXMmg/3qoxqoO4S7K/8kr/wSkZvsyXTQwysd3jz5n973ww5Jvp9crNBW4f1gbin3qDHk8Q7ALNSk6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpUgyPoA; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpUgyPoA"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495482c36b8so15754975e9.0
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784564512; x=1785169312; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=stbwh1TlSlsm7qqGCEf/6eqyf2AXTrm0T0HbGR7Vf9Y=;
        b=MpUgyPoALHyEy14VLClKcfagYKjhVPNIrAuMIPKAWSorEMn1C1a6YACaKks64rURHQ
         W3L6r7rFMMFUT8I4AJTkkXmH5J1hFZbv7tzMcRhmwBGoCrOtT8smT7TRMCamRH4PqIFM
         YQJPAkDJ0g7rgti8vlMasf3SLU+l8Ry9mA5Wh6XzNRRekbBaoenx23x41COlVXxhAQwp
         csdXmHKDc6kystGsJKgxjZSqk/1dVzEk/0A7D5GBdZWGvSpm9f+XFV2eQ0eg+Fdyu/Uc
         itLdKHeAhguhlH0eMtFEYhU4ddiMKqGpkYfM2urRKxUoMYO3zqgDVR7iNmQZ7l7SCmTS
         RxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564512; x=1785169312;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=stbwh1TlSlsm7qqGCEf/6eqyf2AXTrm0T0HbGR7Vf9Y=;
        b=FPvncl0qNLxGyDmBGyuZZQnK7+igyhzqxIVFbrT2OWiGJspxLzgRqKGGV+Rp4QSz5R
         M9QpaFEqxyM+xGAsgaKAgmF7XWbpypsYD5sj/bEV5UsszB88yZSHA1oUUv9tG0007MpD
         Yo7GlQRuDM0s7bb/ApZdpq9L/uwTno9E2TYuA5XatZsxgb9ayl/P4Ing2FQH0mJbSCcq
         xe9YwPr8psmy5v4Uxsno3/ToE6D6EkFh1aIsSwkxRh2Mf1oHli4Ti5NfLC6c7zq3WPE7
         Hg5So1K0m5ocwOl25IyxeeothllcVTlZuVfBuX+cNimeDzOUtxKTho5wF1owmwDzD6ut
         yGaA==
X-Gm-Message-State: AOJu0YxzJZT3MkF21XX68br3ZQsoqz8E3C1gDcXUZCCxv/eJ8ajjlTR/
	i+prkfMpa57DwVgdeyHi9UiXqCUsvv/Bc7a2brutTGzehuDIsV+3ptE+mI87+n+K
X-Gm-Gg: AfdE7cl9PRvEYluFNu8hs6dlwzpLCHRdZ8jqN7jKiSRzYhCaEAEa62vFRtmdmSCj9Mb
	UECb6T6TrNx35cGuCrciFv6SeM0uO7MqulvPeWBOUCJ6c6szWkjXrDyi/4tOHz7xLbozwx3Bo4a
	uNOZRkFw8qUL6A+xvjw/aM/ebj27yY1bS/sgLtwseJQmE9G4ZxSrAVsWGv4EpEk8uf+eiCRu5KQ
	I9RWeerCZquyg5HUjijZkSqH9sXmnO++HR6RALOndX0E1nd/4O4KFr668TrhyXDbOC0Nk2gHS4W
	9oSYmGdlSf4N2mBLB9JWMkhbXU9tahwWE76WMNaARIJts/IbiqXAHmNjO7wPOwDca3Z0mfnG7+W
	UtM4GfrQOHuyjj6B3usSgMM11VMjic46zuzCrnyrg30Iy17aVzu0Ns0BPBpxJI+PJeMPLMkZvte
	QAlQ+GsYRhRSbc4qIWnGqkCu/HXnjEtWhM0RS8NZrywWlHeycX+rnOs0uT4QNq48O7iAqjc0wE/
	OEGyBktC/+3rRkyb20QFMmfGblZRC/nwS92Sf7aMTOF
X-Received: by 2002:a05:600c:524a:b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-495641abe94mr21767565e9.13.1784564512031;
        Mon, 20 Jul 2026 09:21:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956537c7desm1794725e9.7.2026.07.20.09.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 18:21:51 +0200
Message-Id: <DK3JBMNLNYLD.2YDG311I01VWT@gmail.com>
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Fix compilation with
 RELEASE=1
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Viktor Malik" <vmalik@redhat.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Eduard Zingerman" <eddyz87@gmail.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Stanislav Fomichev"
 <sdf@fomichev.me>
X-Mailer: aerc 0.21.0
References: <cover.1784112948.git.vmalik@redhat.com>
 <CAP01T74To6X_XPeM5L9wN52QuL8oSuoDA3jk3jhR_Y1bLXH2Lw@mail.gmail.com>
 <c49fbf3d-c1de-4eb3-a6b4-22c7bc84d655@redhat.com>
In-Reply-To: <c49fbf3d-c1de-4eb3-a6b4-22c7bc84d655@redhat.com>

On Wed Jul 15, 2026 at 3:30 PM CEST, Viktor Malik wrote:
> On 7/15/26 14:10, Kumar Kartikeya Dwivedi wrote:
>> On Wed, 15 Jul 2026 at 13:22, Viktor Malik <vmalik@redhat.com> wrote:
>>>
>>> When compiling BPF selftests with RELEASE=3D1 (which most notably adds
>>> -O2), GCC reports several warnings. These are by default treated as
>>> errors and abort the compilation.
>>>
>>> This series fixes all of the issues such that selftests can be compiled
>>> with RELEASE=3D1.
>>>
>>
>> Are these changes sufficient to fix all issues? I see more when I
>> compile with GCC 15 and RELEASE=3D1.
>
> Strange, I tried compiling with both GCC 15 and 16 and these four
> patches got rid of all the issues. Can you send the specific issues that
> you see?
>

  In file included from /usr/include/features.h:539,
                   from /usr/include/arpa/inet.h:21,
                   from tools/testing/selftests/bpf/map_tests/lpm_trie_map_=
batch_ops.c:3:
  In function =E2=80=98inet_ntop=E2=80=99,
      inlined from =E2=80=98map_batch_verify.constprop=E2=80=99 at tools/te=
sting/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c:53:3:
  /usr/include/x86_64-linux-gnu/bits/inet-fortified.h:36:10: error: call to=
 =E2=80=98__inet_ntop_chk_warn=E2=80=99 declared with attribute warning: in=
et_ntop called with
  bigger length than size of destination buffer [-Werror=3Dattribute-warnin=
g]
     36 |   return __glibc_fortify (inet_ntop, __dst_size, sizeof (char),
        |          ^~~~~~~~~~~~~~~

  In file included from /usr/include/fcntl.h:342,
                   from tools/testing/selftests/bpf/prog_tests/cgroup_xattr=
.c:5:
  In function =E2=80=98open=E2=80=99,
      inlined from =E2=80=98test_read_cgroup_xattr=E2=80=99 at tools/testin=
g/selftests/bpf/prog_tests/cgroup_xattr.c:52:11,
      inlined from =E2=80=98test_cgroup_xattr=E2=80=99 at tools/testing/sel=
ftests/bpf/prog_tests/cgroup_xattr.c:71:3:
  /usr/include/x86_64-linux-gnu/bits/fcntl2.h:52:11: error: call to =E2=80=
=98__open_missing_mode=E2=80=99 declared with attribute error: open with O_=
CREAT or O_TMPFILE in
  second argument needs 3 arguments
     52 |           __open_missing_mode ();
        |           ^~~~~~~~~~~~~~~~~~~~~~

That said, it also fixes the ones you pointed out, so we can probably land =
this.

>> Also, is there no way to make ASSERT_OK_PTR work when we're testing
>> for non-NULL-ness? Having to change it to explicit !=3D NULL is kinda
>> sad.
>
> ASSERT_OK_PTR uses libbpf_get_error(), which returns -errno when the
> passed pointer is NULL. This is correct for checking pointers returned
> from libbpf because libbpf always sets errno when it returns NULL as an
> erroneous value of a pointer. However, that is not the case for other
> library functions, such as malloc(), so calling libbpf_get_error() on
> their result may actually return 0, if the function returned NULL and
> never set errno.
>
> So, I'd say that in the current state, results of non-libbpf
> ptr-returning functions should be checked with ASSERT_NEQ.
> Alternatively, we can update ASSERT_OK_PTR to explicitly fail with a
> default error code when NULL is passed, for example:
>
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
> index 2cf950afcd85..bf94b0947790 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -390,7 +390,7 @@ void hexdump(const char *prefix, const void *buf, siz=
e_t len);
>  #define ASSERT_OK_PTR(ptr, name) ({                                    \
>         static int duration =3D 0;                                       =
 \
>         const void *___res =3D (ptr);                                    =
 \
> -       int ___err =3D libbpf_get_error(___res);                         =
 \
> +       int ___err =3D ___res ? libbpf_get_error(___res) : -EINVAL;      =
 \
>         bool ___ok =3D ___err =3D=3D 0;                                  =
     \
>         CHECK(!___ok, (name), "unexpected error: %d\n", ___err);        \
>         ___ok;                                                          \
>
> However, that would make us lose the error codes passed via errno from
> libbpf.

Hmm, I see. I guess we can let it be then. Eduard, any suggestions or
preferences here?  Otherwise I am inclined to apply this for now.

>
> Viktor

