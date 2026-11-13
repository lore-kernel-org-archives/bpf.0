Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589209;
	b=k/gK64C44DXJNB+iVPSpAZSf3x0SB3yun4Db4pq9NHQxRTPYFrDYMgGl9USDfXbzz30q
	 sGZOiwTiPUggrTUEAMqqHabrA4yz3vRQXCJgyuLgefhNvka411IJ1nekUBrYkJ/XcKNdF
	 9QZOC4iCTGPVeS8DN683XS0mkkRZBwtZoukJhBgiGJOKQ+d4AUk8UDEd93h+jqg5aw5uY
	 kSK0qTOeb4nwh6ixBWVMazNQWQAmiosaomvkCBlmMwZ02jKeSGx0x1DdLPdjCrvvPkeEA
	 lR3Y1vo9znJRP5EGrK5eqUmVXxWgVA9TnVae/xFf4yYFKl3+63zXyLyYOp0zcftvrLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=scUARIYa6JlZqbM9o9X8UDZhtH4UB7ysOYNW/jveLZY=;
	b=zsO//lhYpmUzRLX1dpTMU0bV8bgIu6H6Id+tnXwTLqMhjonCKcuf/3nmBeFNGZn3Zy+Z
	 yhTMCW7jRgxDfwqQfo+0bxfo5o0JeXw6maHXnxSkatRe4ZqCd6R+rRihdu7XAUMKCd1Ww
	 1hObKBHmvPPFxto9DcOQhI/+C5iiCya+YTaQma8Hz8ytIcMQF2RSUf5XdUhR0795bSodl
	 2WWoogR9w97ohP8osNuLR+Ag/5idewAZMTvsoqpiULuKktVwNlZHEcfvJOYNjMVgz+kbd
	 EO1PQGmwXSJVNx4toKFUHiUfwhSvE813/wJZDLSSUwdVxcflqbOFmWkG7CfTyrLvJ8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZBf70J36;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE3606AA23
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 17:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72EE3606AA23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZBf70J36
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4b76c15ae36so88985e9.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 09:00:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794589207; cv=none;
        d=google.com; s=arc-20260327;
        b=dhRUO+CnbWbbvfEtAzZbadNSCME+WGKcrUHV96g1Iw4+A3ZyFPgMX0lsLd4kG4N1UK
         E7ziCPSsbRIGrE6TTZey/0d+5HwZB+/5HrnlVVdk6/FicBrkLypT39+w3y3y8CIPkGGX
         JxrknjYA5nM1VnxbCo1BwfXnuOEjABG508LKz8YVO3BUVwi2n63g0JIt60ayk3Bvh3j+
         FRYDsmzlOX9ahE/DjtyrEjmHpgHwerwyhATTB8SDX/+3PHcvBI5MwrC6OTOtInCJV5+q
         ultGVfvOWsDkjf/6aOeiNejr0T8KsHRG7qlwevSaKLNcL5IEfJ/I4oD8nS+CmcUfcqKd
         rx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=scUARIYa6JlZqbM9o9X8UDZhtH4UB7ysOYNW/jveLZY=;
        fh=SrhPbBZbqkSo+nHE6b+ChQnHiXCmVhmlpcvzGa3DO+4=;
        b=I8UXb9bQPj+B+Wpqq0+aSe0gUFS+dzRVyqnZZdAZ4C9DUZkuAmcWrbS9uBH3FwVfoQ
         VaOa1JY+BKTyxgjiKmWpdOzVk1naz7PQ6e1gzYOG6K20U4jghwp8Dt/AP1o1qEhJqp4T
         Gm9jYR2RYEI7Ld0fVkD5zipKzD19aac8jEshXQeNkkpit8cpr69FJ/zi0wOG6B7mPxUS
         xu00IMted0FT9igXD8qLmk4ZRu5GZnCTH1Uet7/3K1A6ARls7eNlGUWpfb0IoRRXZDSM
         E8In+g+RSSlOtZEKKr6148VFPyJQBfDpXDLtuAlznkomsdZOfpUbbUBqjFMxi1lRPOlw
         QjYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794589207; x=1795194007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=scUARIYa6JlZqbM9o9X8UDZhtH4UB7ysOYNW/jveLZY=;
        b=ZBf70J36PbEu4eQ+SNTy5zuGy74PhNTaJdDpje3jNp4bPngtmrGES7egt+vv9prBpg
         4L+4nnjiSSDwLYLRb7VYtr1pG7rqHFuj68TMPdxGvi+d07fbBK72knjwosg+tvLZVmV/
         7yap3Bwfb0oJ9CEU3qPJ9EtDfvRM1Yp3YX8PCWJE5guWzcu5Prz7Ua7WjmgG4Mk/toBa
         OyMSpBPdjlTPUD5hAB+9e4VyPGoJmII+Wms0dgUdh9QMy7xYARZvhjYiSvZCgVPHfDAO
         PnPRn6RoneZ6phOLPC7VAO4v53np23+EF8R1aqe2QwPx+QontsvLjdFsMHt6PuDpRC6G
         2xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589207; x=1795194007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=scUARIYa6JlZqbM9o9X8UDZhtH4UB7ysOYNW/jveLZY=;
        b=hVNCAeDN0FUhRUFjOC+GYXaaGEOMuYQYBjQ7iN93FZwZiFWkhzEXPIgYfbiCBE1FvU
         Cr/9ddlCGQCKXF87aEAaLTfBcu+BTriXGNDV35FZKKkPNGxQ8lrC2YqEBjasI+VbJ0Ss
         wLyXSIUfquDBGKvbo85Yatw0q1CxoqKrZrr+ig2eqPrzvsd4YKUU0OngY71C8aVwXtAp
         ObgxzopC6Gk8pvmkAsuXEHZgls2FOGVghCCcIRZ6icAh/IxCKhh0mVQO1rk4q4u/rvmG
         WDqFtQUTiOA815qPL3dvhGik+HOqbf9Tt5V4NNLQOvqqOJ6YLtO/oSUd0qLsKcjc677o
         P/tw==
X-Forwarded-Encrypted: i=1; AL+hErEZkJBtYvHxV5npci0iVDp9vDkbOEoyOEesOGP0vnBcWfzdVQt23N7QaPQN8cZb62npyXg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PK9H7iC/7gLA8QSeAwEWv+cBq1cT63fLaiJvniTg6s7Qm20HW
	/PnZHxOaxC9Vc7Xpx+ApQpMz8oVdf7BheCB+7gtocZL19lBosFqm1dbpN0Z3PR75us2gEqX2Lc9
	nfllcjo0TN1aGPaF6yEwXZYz3/LSb487Z9gHuSrcY
X-Gm-Gg: AYBFou3M402jlMAzYrNA9oZrSXyGgRgvY6x6xrFcuhdSyJKBn5VZ9/ISjKfQJ9gPaWA
	LgENJjwPUYdsSztm/dQPtNhSujK5zcUDM66sdwKFcoVgeAbYIQdNUvhtEouDkeMALzhLrrEAGFh
	ZA893SpIJJtOp44kno+Vm0UpcacVfnDqlkIqpJk4zp0FzlooEQNLkyJ6Z8FN+jrvQ6XJ6klgR4O
	3EgpLsUegEobU0QUWaYCHtVU/jC4CLEw4mP0ec5WMB8zrHotwA5bdH+wFwDcf+AQhfQpsJaYz2k
	nQgycOtsagbKQVESEUMS9JfpitxzRlsMCidYRHDBxU+ao6XrbER/qLzNCT+h/XjbDZ9Upqjb+G4
	hC0/tDLMZL5lBAKj/zKDME9M+RgGlbgYMP7zmNv9lDbKSCAKN9JLeDopU3bElFYfS0We6yt+Iq+
	dqgdYDwKpMrhbFETxz79FJ5bvo
X-Received: by 2002:a05:600c:870c:b0:4a2:ba3:236e with SMTP id
 5b1f17b1804b1-4bb56e56238mr936435e9.14.1794589206285; Fri, 13 Nov 2026
 09:00:06 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113024447.922683-1-k.chen@smail.nju.edu.cn>
 <20261113035640.948458-1-k.chen@smail.nju.edu.cn> <20261113035640.948458-2-k.chen@smail.nju.edu.cn>
In-Reply-To: <20261113035640.948458-2-k.chen@smail.nju.edu.cn>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 13 Nov 2026 08:59:53 -0800
X-Gm-Features: AclHuK9SEKgiz7MAOQEc_T8XPTeLCyBuqWo3mPZz76potYWEjTPup_06Sl92Rh4
Message-ID: <CABdmKX1AskqjkCcL8Xu7zqgoBCeXjoeRuQggFNxq7ktSo+ij3g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test that a drained dmabuf
 iterator keeps returning NULL
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 7:57=E2=80=AFPM Kang Chen <k.chen@smail.nju.edu.cn>=
 wrote:
>
> The BPF iterator docs in bpf_iterators.rst specify that the next
> function of an open-coded iterator should keep returning NULL after it
> has been returned once.
>
> Add a subtest that checks this for the dmabuf iterator.  It drains an
> iterator, calls bpf_iter_dmabuf_next() once more and checks that the
> result is NULL.  The dma-bufs the test creates keep the list from being
> empty, so an iterator that starts over would return one of them.
>
> The existing open_coded subtest uses bpf_for_each(), which stops at the
> first NULL and never calls next() on a drained iterator.
>
> The selftest was originally posted by T.J. Mercier in the v1 thread:
>
> Link: https://lore.kernel.org/bpf/CABdmKX09vLG4U-7FwF-vm_iTy1AjGUPXka08Kh=
WE+qJ0J=3DXGMA@mail.gmail.com/
>
> Co-developed-by: T.J. Mercier <tjmercier@google.com>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>

This should be:
From: T.J. Mercier <tjmercier@google.com>

<unmodified original commit message>

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>


For example see:
https://lore.kernel.org/all/20261104-v2_20230123_tjmercier_google_com-v4-1-=
1819a017000b@redhat.com/
and: https://docs.kernel.org/process/submitting-patches.html#from-line


> ---
> v3:
> - Add T.J. Mercier's Co-developed-by and matching Signed-off-by.
> - No code change.
>
>  .../selftests/bpf/prog_tests/dmabuf_iter.c    | 19 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/dmabuf_iter.c | 19 +++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools=
/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> index 1a5dc1adae73..c1f81b5dccdc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> @@ -265,6 +265,23 @@ static void subtest_dmabuf_iter_check_open_coded(str=
uct dmabuf_iter *skel, int m
>         } while (bpf_map_get_next_key(map_fd, key, key));
>  }
>
> +static void subtest_dmabuf_iter_check_next_after_drain(struct dmabuf_ite=
r *skel)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> +       int err, fd;
> +
> +       fd =3D bpf_program__fd(skel->progs.iter_dmabuf_next_after_drain);
> +
> +       err =3D bpf_prog_test_run_opts(fd, &topts);
> +       if (!ASSERT_OK(err, "test_run_opts err"))
> +               return;
> +       if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
> +               return;
> +
> +       /* The test buffers exist, so a restarted iteration would find on=
e */
> +       ASSERT_EQ(skel->data->next_after_drain, 0, "next_after_drain");
> +}
> +
>  void test_dmabuf_iter(void)
>  {
>         struct dmabuf_iter *skel =3D NULL;
> @@ -315,6 +332,8 @@ void test_dmabuf_iter(void)
>         }
>         if (test__start_subtest("open_coded"))
>                 subtest_dmabuf_iter_check_open_coded(skel, map_fd);
> +       if (test__start_subtest("next_after_drain"))
> +               subtest_dmabuf_iter_check_next_after_drain(skel);
>
>  destroy:
>         destroy_test_buffers();
> diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/test=
ing/selftests/bpf/progs/dmabuf_iter.c
> index 9cbb7442646e..d5421b75c39c 100644
> --- a/tools/testing/selftests/bpf/progs/dmabuf_iter.c
> +++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
> @@ -99,3 +99,22 @@ int iter_dmabuf_for_each(const void *ctx)
>
>         return 0;
>  }
> +
> +/* Result of a bpf_iter_dmabuf_next() call after the iterator was draine=
d */
> +__u64 next_after_drain =3D -1;
> +
> +SEC("syscall")
> +int iter_dmabuf_next_after_drain(const void *ctx)
> +{
> +       struct bpf_iter_dmabuf it;
> +
> +       bpf_iter_dmabuf_new(&it);
> +       while (bpf_iter_dmabuf_next(&it))
> +               ;
> +
> +       /* Store the raw value; the verifier would remove a branch on it =
*/
> +       next_after_drain =3D (__u64)bpf_iter_dmabuf_next(&it);
> +       bpf_iter_dmabuf_destroy(&it);
> +
> +       return 0;
> +}
> --
> 2.34.1
>
