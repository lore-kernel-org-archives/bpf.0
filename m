Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C4332623
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177561; cv=pass; b=BE2zd09XnfLjj+apHtB++SpyXFxxNPvj7DnWnRN70T4xK7c7ovy/Ue63uWyBHlUkh4i/+f2gcENOgJA/EUB+BMtOwmAJdw+4LKqbw/UWCZn6Tvyj2nauUuZ+d6hW1V02V9unfvL1s8R9gK7lmg+wATGQuCvkiYQlTA7ynr417tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177561; c=relaxed/simple;
	bh=zx0b9AICqtN7KOq+7V9TM6NL1IMV7Pa0c83daR1BGRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gc8vDPUFzXSiEM+Xi46m/MmBl2Y8BKIjTeqCiD97yGHdKRUkNAJ1RvYaU8kJ/yx2lGApXt5lYY2hYwKQ+GpcdIWTCT94oAPX//LzWBeBtlRH2mbgx8WXn30mzE3juwbOgZRAwl39qiqA5b+99ctWjXoFfq3JU4Fxi8ThpSGNI0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4+Q482+; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4+Q482+"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64c9a6d6b70so1420535d50.3
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 23:32:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772177559; cv=none;
        d=google.com; s=arc-20240605;
        b=PjHKH3gw0WW7XjLUPXvG4pssRnvsmfqtXOzN427PPvF31KRrWJj+7Qrk7OoSD2izG+
         BvBv0NmYgbuGmvVsEF8VZGW5ZRW49v7hL+5MM7aHr1OZDt7HxTvdgAWXcLWPioFvVLwH
         yg7m+NGIDHQPdP7OkAkh61xA612lOh/bDVXofbZHFMVhoov9iVA0KEONJRc9Rxt/fmwA
         e/ErxNmliq+7JkcCZ3zEwRYmidRku1UG25R5/fLcaflLGbo8jAxPvguZS5QhXzSYChBX
         b+J6UNcGZkCmz5DBpXIZIJXjDuY7N2v2QuZ3VoCP7gZIz1r1sTC2j7XngkOxD5k43bsX
         1jwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f2NoK3bvD4X7zfFMY7xOQfMPlCv5rCD1tTdIK7MwMmc=;
        fh=84AfivWya3/CiK0EW0YHzmzfMCrsUectuCHVtQlXpM8=;
        b=P/266tiy6AqPetq9P4q2aSO1w6e/vvGLzVTLH2TU2RN9IMxNWZ6ApuUCHQiP8OVSQB
         aGq3fPx4UyLVnS9gTNV37UzNWfu9R5I7xkTwyShePXu2NiplY3sBHOLHXX/Hv8/Mo47f
         fIVcKKh9R6mtUeXMQJFQGS63LNqJowCpUG5YkM3pRMnsl7cs09/ZTXVDUS3O0x19MOuR
         6Q3QP8fdJA4v0WiBfzs2Xs8lKjgRHBIjqmC9bqUAtMBXTbbjatClb8wvatErvz7QCcXj
         cP/weBpyXBoZpua37Y2LNaNFzTdZpSsRDb/vZO1BVD1afZAS81tsOvawR0ju5fw5Aity
         JznA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772177559; x=1772782359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2NoK3bvD4X7zfFMY7xOQfMPlCv5rCD1tTdIK7MwMmc=;
        b=B4+Q482+655R9dWw38XkDaCAn0j0FMpVJuSbHFw278YbvEdmeswmk03DR4Tt+0a0Cl
         p7nKpMpZNwwIAZdyMa7NsBgF/rSwC4s7KKG8MIrGtxioIHctam8cGjZe9FN9qfjGNEa+
         yDXwF8TXJIrqC5HPs/ActimM2pEisBMuIkTWOL7wbL7VxRll+0J+oSB2Ewzb7rWpnr7h
         ScuiCCIjl33uj6JP6IYP1p374VrxP7T4vgMameSYgdtAAuiDnPwlc/SQWIVEl2hHRZvP
         kY9jcp3fGnHG1CPerQSFZW8nyxnN/Cut59Sv9nnMFbACJSohS8BLC/VUKU3xdcu4skuL
         ftnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772177559; x=1772782359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f2NoK3bvD4X7zfFMY7xOQfMPlCv5rCD1tTdIK7MwMmc=;
        b=nrMpx3Sh7xru+Xk0z7pj3CfswJ8UuOBFK/kB1gOmXMNKDN8tl7nWHDrfNTCuXJPVNy
         WNVYSdVD8Ngj8p6MYyVGe88Qs1I++aKNxZlHWyDqWeAWnBlZXQBbi0Coq6XchtBOVn0g
         1I29PXho/82qvbfJQ6GSPCZsR8g8XSpX3tLj/P4Bu4prULOZ3IrgDwfMjk4ILwWpJCZ8
         9wlOVfwPJodDt+xZ5iuVV6+BNXeLfu7v/RFhUXNYGkfRJ9jwniqZ2mr+RtZWCFZ8Ursk
         LsrfaNZIty6zDaXGpqQx32f7ueolNxkXV0ob/ZNko0Jc827MATpCUvrHruneTY2SR3Na
         zqvA==
X-Gm-Message-State: AOJu0Ywjb7RnNxgWYubMxhgFV0E3flFpLb4h79PRcAb1SXgL3AVQiYrF
	5dcOdytIkpVvEUC7VhRjNBSsBWjY1jBS+AoALyzbT28ZrSuslhRE+4GI5J4cVVlxvr61HODbD7D
	CxUh4U0JZ2Tz3QN5fMYVIpl4zEMsteLqoBqoDgGE=
X-Gm-Gg: ATEYQzxu9wlaoqeFsuQbXR2YLt3VBnKd/XuEaGjViGkVaZJIfiTGzoWffOh8nLQuBPG
	mgHV9Zd8T3sa+Go8MMhs+aOOTh9OwnK0szHyRqj09RUq710e1XJCbQBDkeLEA4xYeRtJQq86ojd
	reTG12rOGIUxW6RuTQp5LBS4VfTILR1kofEgGr8iIBX6k6PCR1jLOD4L+4tTmmbYqh74fLCjGTK
	wjyeDlfjxn+syL7iA1e4U9pLw4HsNWULEfmi8RqXsawk0dEOsSSyGxKsmCzSNq1V+cpzCxTVy22
	k2iYK90=
X-Received: by 2002:a53:e7ca:0:b0:649:ae49:f58d with SMTP id
 956f58d0204a3-64cc211f15fmr1200739d50.26.1772177559068; Thu, 26 Feb 2026
 23:32:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227052031.3988575-1-memxor@gmail.com> <20260227052031.3988575-6-memxor@gmail.com>
In-Reply-To: <20260227052031.3988575-6-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 26 Feb 2026 23:32:27 -0800
X-Gm-Features: AaiRm52zQpNztpAZfJmPhpHmLXbQ26dHLHAIw9V_Mo3uoUA_aCZuvHoFplqjQPM
Message-ID: <CAMB2axN48Po5LxPN2Pub3i_w2eb55FRxyM1OCuKfEpOtgMR-pg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 5/5] selftests/bpf: Add tests for special fields races
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 9:21=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Add a couple of tests to ensure that the refcount drops to zero when we
> exercise the race where creation of a special field succeeds the logical
> bpf_obj_free_fields done when deleting an element. Prior to previous
> changes, the fields would be freed eagerly and repopulate and end up
> leaking, causing the reference to not drop down correctly. Running this
> test on a kernel without fixes will cause a hang in delete_module, since
> the module reference stays active due to the leaked kptr not dropping
> it. After the fixes tests succeed as expected.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/map_kptr_race.c  | 218 ++++++++++++++++++
>  .../selftests/bpf/progs/map_kptr_race.c       | 197 ++++++++++++++++
>  2 files changed, 415 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr_race.=
c
>  create mode 100644 tools/testing/selftests/bpf/progs/map_kptr_race.c

Reviewed-by: Amery Hung <ameryhung@gmail.com>

>
> diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c b/too=
ls/testing/selftests/bpf/prog_tests/map_kptr_race.c
> new file mode 100644
> index 000000000000..506ed55e8528
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +
> +#include "map_kptr_race.skel.h"
> +
> +static int get_map_id(int map_fd)
> +{
> +       struct bpf_map_info info =3D {};
> +       __u32 len =3D sizeof(info);
> +
> +       if (!ASSERT_OK(bpf_map_get_info_by_fd(map_fd, &info, &len), "get_=
map_info"))
> +               return -1;
> +       return info.id;
> +}
> +
> +static int read_refs(struct map_kptr_race *skel)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, opts);
> +       int ret;
> +
> +       ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.count_=
ref), &opts);
> +       if (!ASSERT_OK(ret, "count_ref run"))
> +               return -1;
> +       if (!ASSERT_OK(opts.retval, "count_ref retval"))
> +               return -1;
> +       return skel->bss->num_of_refs;
> +}
> +
> +static void test_htab_leak(void)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, opts,
> +               .data_in =3D &pkt_v4,
> +               .data_size_in =3D sizeof(pkt_v4),
> +               .repeat =3D 1,
> +       );
> +       struct map_kptr_race *skel, *watcher;
> +       int ret, map_id;
> +
> +       skel =3D map_kptr_race__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +               return;
> +
> +       ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_h=
tab_leak), &opts);
> +       if (!ASSERT_OK(ret, "test_htab_leak run"))
> +               goto out_skel;
> +       if (!ASSERT_OK(opts.retval, "test_htab_leak retval"))
> +               goto out_skel;
> +
> +       map_id =3D get_map_id(bpf_map__fd(skel->maps.race_hash_map));
> +       if (!ASSERT_GE(map_id, 0, "map_id"))
> +               goto out_skel;
> +
> +       watcher =3D map_kptr_race__open_and_load();
> +       if (!ASSERT_OK_PTR(watcher, "watcher open_and_load"))
> +               goto out_skel;
> +
> +       watcher->bss->target_map_id =3D map_id;
> +       watcher->links.map_put =3D bpf_program__attach(watcher->progs.map=
_put);
> +       if (!ASSERT_OK_PTR(watcher->links.map_put, "attach fentry"))
> +               goto out_watcher;
> +       watcher->links.htab_map_free =3D bpf_program__attach(watcher->pro=
gs.htab_map_free);
> +       if (!ASSERT_OK_PTR(watcher->links.htab_map_free, "attach fexit"))
> +               goto out_watcher;
> +
> +       map_kptr_race__destroy(skel);
> +       skel =3D NULL;
> +
> +       kern_sync_rcu();
> +
> +       while (!READ_ONCE(watcher->bss->map_freed))
> +               sched_yield();
> +
> +       ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
> +       ASSERT_EQ(read_refs(watcher), 2, "htab refcount");
> +
> +out_watcher:
> +       map_kptr_race__destroy(watcher);
> +out_skel:
> +       map_kptr_race__destroy(skel);
> +}
> +
> +static void test_percpu_htab_leak(void)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, opts,
> +               .data_in =3D &pkt_v4,
> +               .data_size_in =3D sizeof(pkt_v4),
> +               .repeat =3D 1,
> +       );
> +       struct map_kptr_race *skel, *watcher;
> +       int ret, map_id;
> +
> +       skel =3D map_kptr_race__open();
> +       if (!ASSERT_OK_PTR(skel, "open"))
> +               return;
> +
> +       skel->rodata->nr_cpus =3D libbpf_num_possible_cpus();
> +       if (skel->rodata->nr_cpus > 16)
> +               skel->rodata->nr_cpus =3D 16;
> +
> +       ret =3D map_kptr_race__load(skel);
> +       if (!ASSERT_OK(ret, "load"))
> +               goto out_skel;
> +
> +       ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_p=
ercpu_htab_leak), &opts);
> +       if (!ASSERT_OK(ret, "test_percpu_htab_leak run"))
> +               goto out_skel;
> +       if (!ASSERT_OK(opts.retval, "test_percpu_htab_leak retval"))
> +               goto out_skel;
> +
> +       map_id =3D get_map_id(bpf_map__fd(skel->maps.race_percpu_hash_map=
));
> +       if (!ASSERT_GE(map_id, 0, "map_id"))
> +               goto out_skel;
> +
> +       watcher =3D map_kptr_race__open_and_load();
> +       if (!ASSERT_OK_PTR(watcher, "watcher open_and_load"))
> +               goto out_skel;
> +
> +       watcher->bss->target_map_id =3D map_id;
> +       watcher->links.map_put =3D bpf_program__attach(watcher->progs.map=
_put);
> +       if (!ASSERT_OK_PTR(watcher->links.map_put, "attach fentry"))
> +               goto out_watcher;
> +       watcher->links.htab_map_free =3D bpf_program__attach(watcher->pro=
gs.htab_map_free);
> +       if (!ASSERT_OK_PTR(watcher->links.htab_map_free, "attach fexit"))
> +               goto out_watcher;
> +
> +       map_kptr_race__destroy(skel);
> +       skel =3D NULL;
> +
> +       kern_sync_rcu();
> +
> +       while (!READ_ONCE(watcher->bss->map_freed))
> +               sched_yield();
> +
> +       ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
> +       ASSERT_EQ(read_refs(watcher), 2, "percpu_htab refcount");
> +
> +out_watcher:
> +       map_kptr_race__destroy(watcher);
> +out_skel:
> +       map_kptr_race__destroy(skel);
> +}
> +
> +static void test_sk_ls_leak(void)
> +{
> +       struct map_kptr_race *skel, *watcher;
> +       int listen_fd =3D -1, client_fd =3D -1, map_id;
> +
> +       skel =3D map_kptr_race__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +               return;
> +
> +       if (!ASSERT_OK(map_kptr_race__attach(skel), "attach"))
> +               goto out_skel;
> +
> +       listen_fd =3D start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
> +       if (!ASSERT_GE(listen_fd, 0, "start_server"))
> +               goto out_skel;
> +
> +       client_fd =3D connect_to_fd(listen_fd, 0);
> +       if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
> +               goto out_skel;
> +
> +       if (!ASSERT_EQ(skel->bss->sk_ls_leak_done, 1, "sk_ls_leak_done"))
> +               goto out_skel;
> +
> +       close(client_fd);
> +       client_fd =3D -1;
> +       close(listen_fd);
> +       listen_fd =3D -1;
> +
> +       map_id =3D get_map_id(bpf_map__fd(skel->maps.race_sk_ls_map));
> +       if (!ASSERT_GE(map_id, 0, "map_id"))
> +               goto out_skel;
> +
> +       watcher =3D map_kptr_race__open_and_load();
> +       if (!ASSERT_OK_PTR(watcher, "watcher open_and_load"))
> +               goto out_skel;
> +
> +       watcher->bss->target_map_id =3D map_id;
> +       watcher->links.map_put =3D bpf_program__attach(watcher->progs.map=
_put);
> +       if (!ASSERT_OK_PTR(watcher->links.map_put, "attach fentry"))
> +               goto out_watcher;
> +       watcher->links.sk_map_free =3D bpf_program__attach(watcher->progs=
.sk_map_free);
> +       if (!ASSERT_OK_PTR(watcher->links.sk_map_free, "attach fexit"))
> +               goto out_watcher;
> +
> +       map_kptr_race__destroy(skel);
> +       skel =3D NULL;
> +
> +       kern_sync_rcu();
> +
> +       while (!READ_ONCE(watcher->bss->map_freed))
> +               sched_yield();
> +
> +       ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
> +       ASSERT_EQ(read_refs(watcher), 2, "sk_ls refcount");
> +
> +out_watcher:
> +       map_kptr_race__destroy(watcher);
> +out_skel:
> +       if (client_fd >=3D 0)
> +               close(client_fd);
> +       if (listen_fd >=3D 0)
> +               close(listen_fd);
> +       map_kptr_race__destroy(skel);
> +}
> +
> +void serial_test_map_kptr_race(void)
> +{
> +       if (test__start_subtest("htab_leak"))
> +               test_htab_leak();
> +       if (test__start_subtest("percpu_htab_leak"))
> +               test_percpu_htab_leak();
> +       if (test__start_subtest("sk_ls_leak"))
> +               test_sk_ls_leak();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/map_kptr_race.c b/tools/te=
sting/selftests/bpf/progs/map_kptr_race.c
> new file mode 100644
> index 000000000000..f6f136cd8f60
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/map_kptr_race.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../test_kmods/bpf_testmod_kfunc.h"
> +
> +struct map_value {
> +       struct prog_test_ref_kfunc __kptr *ref_ptr;
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> +       __type(key, int);
> +       __type(value, struct map_value);
> +       __uint(max_entries, 1);
> +} race_hash_map SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERCPU_HASH);
> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> +       __type(key, int);
> +       __type(value, struct map_value);
> +       __uint(max_entries, 1);
> +} race_percpu_hash_map SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_SK_STORAGE);
> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> +       __type(key, int);
> +       __type(value, struct map_value);
> +} race_sk_ls_map SEC(".maps");
> +
> +int num_of_refs;
> +int sk_ls_leak_done;
> +int target_map_id;
> +int map_freed;
> +const volatile int nr_cpus;
> +
> +SEC("tc")
> +int test_htab_leak(struct __sk_buff *skb)
> +{
> +       struct prog_test_ref_kfunc *p, *old;
> +       struct map_value val =3D {};
> +       struct map_value *v;
> +       int key =3D 0;
> +
> +       if (bpf_map_update_elem(&race_hash_map, &key, &val, BPF_ANY))
> +               return 1;
> +
> +       v =3D bpf_map_lookup_elem(&race_hash_map, &key);
> +       if (!v)
> +               return 2;
> +
> +       p =3D bpf_kfunc_call_test_acquire(&(unsigned long){0});
> +       if (!p)
> +               return 3;
> +       old =3D bpf_kptr_xchg(&v->ref_ptr, p);
> +       if (old)
> +               bpf_kfunc_call_test_release(old);
> +
> +       bpf_map_delete_elem(&race_hash_map, &key);
> +
> +       p =3D bpf_kfunc_call_test_acquire(&(unsigned long){0});
> +       if (!p)
> +               return 4;
> +       old =3D bpf_kptr_xchg(&v->ref_ptr, p);
> +       if (old)
> +               bpf_kfunc_call_test_release(old);
> +
> +       return 0;
> +}
> +
> +static int fill_percpu_kptr(struct map_value *v)
> +{
> +       struct prog_test_ref_kfunc *p, *old;
> +
> +       p =3D bpf_kfunc_call_test_acquire(&(unsigned long){0});
> +       if (!p)
> +               return 1;
> +       old =3D bpf_kptr_xchg(&v->ref_ptr, p);
> +       if (old)
> +               bpf_kfunc_call_test_release(old);
> +       return 0;
> +}
> +
> +SEC("tc")
> +int test_percpu_htab_leak(struct __sk_buff *skb)
> +{
> +       struct map_value *v, *arr[16] =3D {};
> +       struct map_value val =3D {};
> +       int key =3D 0;
> +       int err =3D 0;
> +
> +       if (bpf_map_update_elem(&race_percpu_hash_map, &key, &val, BPF_AN=
Y))
> +               return 1;
> +
> +       for (int i =3D 0; i < nr_cpus; i++) {
> +               v =3D bpf_map_lookup_percpu_elem(&race_percpu_hash_map, &=
key, i);
> +               if (!v)
> +                       return 2;
> +               arr[i] =3D v;
> +       }
> +
> +       bpf_map_delete_elem(&race_percpu_hash_map, &key);
> +
> +       for (int i =3D 0; i < nr_cpus; i++) {
> +               v =3D arr[i];
> +               err =3D fill_percpu_kptr(v);
> +               if (err)
> +                       return 3;
> +       }
> +
> +       return 0;
> +}
> +
> +SEC("tp_btf/inet_sock_set_state")
> +int BPF_PROG(test_sk_ls_leak, struct sock *sk, int oldstate, int newstat=
e)
> +{
> +       struct prog_test_ref_kfunc *p, *old;
> +       struct map_value *v;
> +
> +       if (newstate !=3D BPF_TCP_SYN_SENT)
> +               return 0;
> +
> +       if (sk_ls_leak_done)
> +               return 0;
> +
> +       v =3D bpf_sk_storage_get(&race_sk_ls_map, sk, NULL,
> +                               BPF_SK_STORAGE_GET_F_CREATE);
> +       if (!v)
> +               return 0;
> +
> +       p =3D bpf_kfunc_call_test_acquire(&(unsigned long){0});
> +       if (!p)
> +               return 0;
> +       old =3D bpf_kptr_xchg(&v->ref_ptr, p);
> +       if (old)
> +               bpf_kfunc_call_test_release(old);
> +
> +       bpf_sk_storage_delete(&race_sk_ls_map, sk);
> +
> +       p =3D bpf_kfunc_call_test_acquire(&(unsigned long){0});
> +       if (!p)
> +               return 0;
> +       old =3D bpf_kptr_xchg(&v->ref_ptr, p);
> +       if (old)
> +               bpf_kfunc_call_test_release(old);
> +
> +       sk_ls_leak_done =3D 1;
> +       return 0;
> +}
> +
> +long target_map_ptr;
> +
> +SEC("fentry/bpf_map_put")
> +int BPF_PROG(map_put, struct bpf_map *map)
> +{
> +       if (target_map_id && map->id =3D=3D (u32)target_map_id)
> +               target_map_ptr =3D (long)map;
> +       return 0;
> +}
> +
> +SEC("fexit/htab_map_free")
> +int BPF_PROG(htab_map_free, struct bpf_map *map)
> +{
> +       if (target_map_ptr && (long)map =3D=3D target_map_ptr)
> +               map_freed =3D 1;
> +       return 0;
> +}
> +
> +SEC("fexit/bpf_sk_storage_map_free")
> +int BPF_PROG(sk_map_free, struct bpf_map *map)
> +{
> +       if (target_map_ptr && (long)map =3D=3D target_map_ptr)
> +               map_freed =3D 1;
> +       return 0;
> +}
> +
> +SEC("syscall")
> +int count_ref(void *ctx)
> +{
> +       struct prog_test_ref_kfunc *p;
> +       unsigned long arg =3D 0;
> +
> +       p =3D bpf_kfunc_call_test_acquire(&arg);
> +       if (!p)
> +               return 1;
> +
> +       num_of_refs =3D p->cnt.refs.counter;
> +
> +       bpf_kfunc_call_test_release(p);
> +       return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.47.3
>
>
