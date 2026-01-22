Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D7322B90
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118838; cv=pass; b=etfm7ZVBge/xMndwLM2NVhI+a1eLBDfP8RzKhkKoS627e/jmVRpkCJBEY0jrAEWu/pUiM079SgXBtulzloMY4xqnzxE/HUiVfOG0Dtfo78hjWUSVEI4jX40aAvgAJ0U06Zl9b7vnZ3+CNjFqqiRYavUlvtSGdgYepVSiYwkWjEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118838; c=relaxed/simple;
	bh=D5BpwZdiulU2a3EPS/oxE6riKvJoJJiO3FzDxftWiBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5eHMvj2HrwIsxRz2Wd5y+V63wexDnSUvpUGqEMSNpYBK1ZSsvEQM4Ezahyrm9lBqJ8K0lvJG9rBCP/cm4HjnPb0cVi9IOWsmmWS53NNFMkVLqhh0Pwybx2/fZfKKxsEl8npajH0v4SERGzoXpxGtLurN9F8gtiqivu/argoi/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4+3tUOp; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4+3tUOp"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-649488dc7bdso1522063d50.0
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 13:53:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769118830; cv=none;
        d=google.com; s=arc-20240605;
        b=Obs+oktVJtXztlZ7W6qA2NpZCGixRkxgoV84bklez2oThWj3hpaUsAOu50nQ46hPXP
         VrkDm8cogKnHN8DPI52r71z0TpVaixPwcg8bdo20JAVqaQypoh8tvnsQaARYZfkhZ+E+
         eVOFDDQjMVIrbY5tk3eckYdL8WcPYR3FWj0MW/yYLy3furJcjLTS08Rk47cKzhkA6VLj
         loNrZNKv3Lla7+KWGhLLYeN49MErn7Dmt5AlKQBYm+kkemYGncn0wAMVBZYNo8XXrxD5
         cdKUl5P3sEHdLaRPHTa1yPvnjWFZHtDqZswDy1HnD+bPQoAJkAzp/gJ4Weyjza6nzCIH
         Vccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tvPOCBkLiFRNywtRjJAzehROUTlYae/mbdp8qbwSYK8=;
        fh=4KubPJPm/oify4h8BPjn9mdYAYp9R/C82vTyHZeZ5Mg=;
        b=F0L09YoJHmuJshazoubYStx/Z3/40dcSUOjPTK/7Sg+laGPNJV13n1Gsg1vYfuvtXc
         cn4tagdpnWMgD4hsbFFLYznHRdS+pDsJ16iwfdTTh65TmN7i8s0KgnFDpJLmm4RRjpl5
         VRl1QXwI7aU4/i4nSCeRsYrNjfs1JFqXJBKec8S4JPQt/PQokP4BQIQeUFJrqGduDIXX
         AxXr/MVRqxbBsK5NTlKzNIfAiGKFsEt2uS2r4igimx9Oku+s5El6KBhJVNbGRoaulIYY
         Kn0uO6bZ6EpZMENaB5znkEDenCrNf0dL+5w7uuql7I5GpllAxFBioRrNpcdgovd96GCn
         KqLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769118830; x=1769723630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvPOCBkLiFRNywtRjJAzehROUTlYae/mbdp8qbwSYK8=;
        b=Y4+3tUOpDz91A4DM3uq/OEj1fYBsk6VCSavJmAreVKMVC4ehVkAH8oSkrPVDeYuNw3
         sPFpyyk0T1bLwUEKRRtoZHBkbOjHxOtwMNnt7ksxzQehI443sZ8jNfHkuWDRKu/Kdeuh
         YLM5RmLQs09AEeKzcLMPKQ1/Pfkg8vF839Wh6iGlAVa5QjOrbiCkgQqH5CAZlu35l3MQ
         MfNakeR1LJYrjq6rD2+GeJZz3vuXhPEeaLv9Qu1TUVgqiMBqitJQ3abGbYSwOheqHMrr
         GgZZ22287gRvU9Xg27/FpfPi0I/MZhXkfDtWEPSWgCSYHxchoQy9wEDUsZySTp631x0W
         r8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769118830; x=1769723630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tvPOCBkLiFRNywtRjJAzehROUTlYae/mbdp8qbwSYK8=;
        b=oaoD2n3W7U9MmCY2hxw4mLYRUvukyhRbGhDAenr4QUWxQt8tCKDYN/IBt10RueNAxV
         GN5XRYWra4xfzR3/8K1KbWAXH7UXUcflGkIMstAfMR/G3E69hGOdTzFNDlLKiqniwjjE
         Ca867ih89eH5dH59iZcmT8UM6qTouY7aQ9x5LTzM7/21rV7vlpMTFG1TPooZw3bFdUnr
         3IDQ0m+17zircAYbgQmhNNYaIMAruCIY3A83972W+6Qz8rYsyQN4wzpVzVxPf65fL7nK
         MnQ3RvvtvcohhO1DV2qp6Lg+Fav5kdeR2bDs/qK19yJ9ZGDXOIFg+nABYDxjkm4CL+JA
         4zJg==
X-Gm-Message-State: AOJu0YzMqcD5g98d1dyXLlNl8BhhQkDJjii+AAbvNl2C9LIMAZCnweA0
	uwrhv3V3QdwrsRt92bOXg+O2uuwCm5jAxSZ70MbXrW+n2Pcw1JkUF9rtIvNnmVOqxK29RSizlT7
	rmyccE0XouIRNt9dCT0PqaT3EpbcMZoQ=
X-Gm-Gg: AZuq6aKkpzoh+4Zfy3zfzilBOO2Db8cgPzdCmRHvVC999EUkRAMESMUDlKMerucmj7t
	AsTS8CcgLxN3RSZLNnQ8fJKeBFqxCKoqJ40O/+xb3WcoH1Lw3ZfjHn5QXH8sRbJOzNZGBfrPP/q
	DrGJHMb01NLTuB5s8ksMTw0UGWZduVFiRfqIdAhV9ZULhcf6nhpZyO2dvxUjaIjzeHVKd2hhz2m
	hV0E2lQmD8YWKBjzSlGY50jty4K/nItHcutlM6SKl0LlSnP+GJW+n7K/ELbKTFwKe4zJVrz2BKP
	8L7k3nMm9kI=
X-Received: by 2002:a05:690e:240f:b0:646:7c7a:c5b5 with SMTP id
 956f58d0204a3-6495bfc99e2mr532120d50.45.1769118830017; Thu, 22 Jan 2026
 13:53:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122162616.3578898-1-yonghong.song@linux.dev>
 <20260122162621.3579387-1-yonghong.song@linux.dev> <CAMB2axP_AaoiZB9BSQ3Mz_M0e0t1S-y3u8KnBx1FY1nCq3qN6Q@mail.gmail.com>
 <d30fce68-01d9-44ef-bb28-28b6d2bdb13d@linux.dev>
In-Reply-To: <d30fce68-01d9-44ef-bb28-28b6d2bdb13d@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 22 Jan 2026 13:53:39 -0800
X-Gm-Features: AZwV_Qg2YK2EKR_vZylx5h7l8LCCFWfpy585BpeQMkRnNsAnxVYGuLl5Gsg3jH0
Message-ID: <CAMB2axP70iNWh-8ZBg-ES5PW2Grn-AMycGb81yYjZemGYwuxQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Fix xdp_pull_data failure
 with 64K page
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 1:38=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 1/22/26 1:18 PM, Amery Hung wrote:
> > On Thu, Jan 22, 2026 at 8:56=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> If the argument 'pull_len' of run_test() is 'PULL_MAX' or
> >> 'PULL_MAX | PULL_PLUS_ONE', the eventual pull_len size
> >> will close to the page size. On arm64 systems with 64K pages,
> >> the pull_len size will be close to 64K. But the existing buffer
> >> will be close to 9000 which is not enough to pull.
> >>
> >> For those failed run_tests(), make buff size to
> >>    2 * pg_sz + (pg_sz / 2)
> >> This way, there will be enough buffer space to pull
> >> regardless of page size.
> >>
> >> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> >> Cc: Amery Hung <ameryhung@gmail.com>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   .../testing/selftests/bpf/prog_tests/xdp_pull_data.c | 12 +++++++---=
--
> >>   1 file changed, 7 insertions(+), 5 deletions(-)
> >>
> >> Changelog:
> >>   v1 -> v2:
> >>     - v1: https://lore.kernel.org/bpf/20260120210930.2544950-1-yonghon=
g.song@linux.dev/
> >>     - Use pg_sz to simplify buff_len calculation.
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/=
tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> >> index efa350d04ec5..35f0eb5b43f3 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> >> @@ -114,12 +114,14 @@ static void test_xdp_pull_data_basic(void)
> >>   {
> >>          u32 pg_sz, max_meta_len, max_data_len;
> >>          struct test_xdp_pull_data *skel;
> >> +       int buff_len;
> >>
> >>          skel =3D test_xdp_pull_data__open_and_load();
> >>          if (!ASSERT_OK_PTR(skel, "test_xdp_pull_data__open_and_load")=
)
> >>                  return;
> >>
> >>          pg_sz =3D sysconf(_SC_PAGE_SIZE);
> >> +       buff_len =3D 2 * pg_sz + pg_sz / 2;
> > Thanks for fixing the test. Just curious if there is an issue with 1.5
> > pg_sz as suggested by Alan?
>
> Although existing 'buff_len =3D 2 * pg_sz + pg_sz / 2' works fine for the=
 test,
> but let us use the Alan's suggestion (buff_len =3D pg_sz + pg_sz / 2)
> since the buffer size is tighter and potentially better for test.

I see. Sounds good.

>
> >
> >>          if (find_xdp_sizes(skel, pg_sz))
> >>                  goto out;
>
> [...]
>
