Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF9343D74
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769038133; cv=pass; b=l/Ey4c9sU4Gk4tmKof8oS0WAtzkM8xgvVmkwFvpZN7PXKPh5ViSXs3XG3fV2TOsQ+11EZA+bKGBqnDJgkQSDabbh5HToqnzlbC6PpI5I9WcKLfEwGujAk8dO0FkGtk8/IHFASvqJ5Mn0NW/nCe9iAbUC71sWLdyJfctNYAxZx68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769038133; c=relaxed/simple;
	bh=upLo6Kag4/ckIE6BlT4A5204/WOZS3o23HaZ+ydyRDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnCAtU7fy5KvJr56BDn2fRa33rnfY9JIapmDt2BXSakbUXhP/X3wPQaTHZbMYl8zuC/MszW5CKd8Acra+5+UBYHWYjBsc9Vg3tCuKzBjfXMPZh5aCpLqCNgKUEaGGkIx2LrXXLUAVXF1HgDQdiOFE+a4XiNE+rUenMDDVYrApjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGdXTWKj; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGdXTWKj"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so45403066b.2
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 15:28:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769038129; cv=none;
        d=google.com; s=arc-20240605;
        b=UBdzjO1rGGplObvp0HiGbscMGz5fygB0cxsikvdtVVQOQ4zdnoVC60z5m+cHJoECRZ
         mJwf4UgKY9uOWKQe/2MtJAuRtBJc0Ri2af+bOiBptjqy7GRS5D86ce1mHfyWbWd7ZsQE
         Zk9LzihqDMuuwlDnRLD7/LQjTDN1xXSI9aeztvXAqxPlJ9TcAxiGPp034kLZU/meHK23
         6wH9wt3jhMsRIwniN8CpcwdMUj0a4HTQewjBTEMdy0kbHZEq4q2V6RvppJNVYoBIfObn
         1Oxovkc9q8OCROdateOmYfCiDft0hsmEEPR1p+JXwmjp5GM+wF++vt6/jY+EtDsZ8OWG
         A/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xqgodCIvZD6Tag40vkYrIK70N3gj+Xw487GJpU6iWA0=;
        fh=U4vtc5AqCQ7uSpfSU8JqSEb1EPrwDH+UDU89JhA9uKQ=;
        b=gAqkX/3MmkiDqZjx/N7XMkjh7m63qLn8Iyge5GXE3yaZmxIX5dtZ79zuTJvB9N+Kl5
         eFcWtkb4b+N3AWk/oceRVOfUwlhRBCJQTi6lXdZnxLJAnxgUUROeLgNDvNUra67Nvpyu
         UTUmoiEpLrlMufDFiXGjoh+m1/vc+6eZhBr49psfyTBcJZ2ev5cieboFEDQlTNEbmePP
         adg81RWNjjCVX+OT7dxgT4fcWSOMM8ZgC+k2oxriCz4WBnCoqGXay+0u/O0/IImVYLdL
         KluIVpRvFRiL03rQetxB4eAlYxslVCf0Pp97U9OSltG3URQvKT7jB+olW1lgyL9yfBS0
         87gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769038129; x=1769642929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqgodCIvZD6Tag40vkYrIK70N3gj+Xw487GJpU6iWA0=;
        b=nGdXTWKj8/JZug6ypdtQ0rrrGzUEv3m6O7QLeI7LR8Bn1yHKnYCI9Dt8RCGRd9FrYt
         pOohWV7APQufe9KPl+Fm3+hUZRPjD5T66gcFZGmkimK2s99GWDKo3Q61ZoMsFIeUT+fU
         Ty3vXSWSxK4jLYsnLpmPXS6vVdqZeCCX4Sf7NVs7xEHjKsuCz57jaSOqgbz6WnWmiJ6m
         s/mSwMZQW9NrI1bGhbxtul1WhEF3LyEIJhbc1vDdBFqsxg5lNlimjUcQZXfZGRagE2ZB
         hVcf98oeGrULR5tWL7LqYLJ0ef/HgFsUjjE2R9kK1ehlDvoAZHBdv6ofrsHx4mBu+SSU
         bYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769038129; x=1769642929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xqgodCIvZD6Tag40vkYrIK70N3gj+Xw487GJpU6iWA0=;
        b=u4X9HZtKPoyPEhVbZbLYi2WvDTZPLKFtguFZw0CUUHhAAl52xj7Bej7MSFMdt2APDb
         r+ucUNMXn8Pfeh1Sq/MX0hv1gD1l2FWcau+LCM27Hmk/JnQ/Va2FKF89+4qJnNb9JX8u
         bSfBHhN/brMLs5fbHozCQwpyncx0hjZIu1aTfrm2Qyf8gUr8f1ar4LhVMdqLsOiy0WnQ
         bG/ge9MsV4SB/mXn6k9utW+jSV6I4foA4quEmtNOpJ4n9d3THPcMlKBDjNHLRqdoVeZl
         c40EEDHHtL6khq8e1ByXJatnb2gllTZKIuHD3SV8jqjZ1uAYwT9DGBosfbV9n90GU3hf
         9/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUTlqJm5cHzAshQ0/ye1cxnzK3QP05q1ScDTIb/yjWbPAFFaPAyP/q+Ta77qrPu/EEmu0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJxa1/N8NVjXNGCuCMkeGHiDCELR67RI4A1EoJkeSRXXt5PYu
	45NQfc1h7Ov3OjixcU/5elHrkpN6O5YPbfNQRKAj2aU7eU1ffSKwayq1MoKdsU3JNXXyybNhzOm
	iTpwJmSqZ4NOnfonT+kHZCfEVGRuwmn+n2+JPhGok
X-Gm-Gg: AZuq6aL8y9CDugimj+jg7b2wi+2HyFcsepRZIkv4pOz6juBD0lsSYbRBZjLKwg/sGFk
	C46GbFTig3RFIocAbuY+vTP/TUNIeDNrgsxAzUSYOp+F8CIl18Kg6rqMDM91vy/3jC233o2APFb
	TKny4+9jxPbtEfuaxf4pCbDgBmb0vwLF7VFNv5jBd62Y6cXFRgfep03dJiWMGGds1Z140NtKhlK
	McXA1Pd0GS0IceKlSVHnGqh8VZQgkRpHsWjpqWujzIUkim48ggKVaAHZ3PUJ2RBAvjDOeyReEHj
	9f0t7jicJC5kcTQpu5TOclK3Ki9eTQ==
X-Received: by 2002:a17:907:9495:b0:b87:d664:860f with SMTP id
 a640c23a62f3a-b8800364e56mr526339066b.51.1769038129086; Wed, 21 Jan 2026
 15:28:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108225523.3268383-1-wusamuel@google.com> <20260108225523.3268383-4-wusamuel@google.com>
 <CAEf4BzaE2WGW3bB_ZsCZsjNLV8bczopH8w89FUaAZH7Qa6G-JA@mail.gmail.com>
In-Reply-To: <CAEf4BzaE2WGW3bB_ZsCZsjNLV8bczopH8w89FUaAZH7Qa6G-JA@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 21 Jan 2026 15:28:37 -0800
X-Gm-Features: AZwV_QgXOnNkKQYdrWPPj0PX-i1o3lzkTCsxuz9sJnpXDNE_Dn3N_hKlXEJkAmA
Message-ID: <CAG2KctpSA41wZyZ+9DxpF6st9OY7MWZRzaw9CfidoZctUWqgtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Add tests for wakeup_sources
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 3:32=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jan 8, 2026 at 2:56=E2=80=AFPM Samuel Wu <wusamuel@google.com> wr=
ote:
> >
> > Sets up the framework to test wakeup_sources iterators using BPF, and
> > adds a few basic tests.
> >
> > Adds several helper functions that for grabbing and releasing a
> > wakelock, abstracting out key functions to setup a framework for testin=
g
> > wakeup_sources.
> >
> > Additionally, adds 3 tests:
> > 1. check_active_count: Checks that stats related to active_count are
> >    properly set after several lock/unlock cycles
> > 2. check_sleep_times: Checks that time accounting related to sleep are
> >    properly calculated
> > 3. check_no_infinite_reads: Checks that the iterator traversal returns
> >    NULL at the end
> >
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > ---
> >  tools/testing/selftests/bpf/config            |   1 +
> >  .../bpf/prog_tests/wakeup_source_iter.c       | 281 ++++++++++++++++++
> >  .../selftests/bpf/progs/wakeup_source_iter.c  |  70 +++++
> >  3 files changed, 352 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_sourc=
e_iter.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_ite=
r.c
> >
> > diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftes=
ts/bpf/config
> > index 558839e3c185..c12c5e04b81f 100644
> > --- a/tools/testing/selftests/bpf/config
> > +++ b/tools/testing/selftests/bpf/config
> > @@ -111,6 +111,7 @@ CONFIG_IP6_NF_IPTABLES=3Dy
> >  CONFIG_IP6_NF_FILTER=3Dy
> >  CONFIG_NF_NAT=3Dy
> >  CONFIG_PACKET=3Dy
> > +CONFIG_PM_WAKELOCKS=3Dy
> >  CONFIG_RC_CORE=3Dy
> >  CONFIG_SAMPLES=3Dy
> >  CONFIG_SAMPLE_LIVEPATCH=3Dm
> > diff --git a/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.=
c b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
> > new file mode 100644
> > index 000000000000..31729f11585e
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
> > @@ -0,0 +1,281 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2026 Google LLC */
> > +
> > +#include <test_progs.h>
> > +#include <bpf/libbpf.h>
> > +#include "wakeup_source_iter.skel.h"
> > +
> > +#include <fcntl.h>
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +
> > +
> > +/* Sleep for 10ms to ensure active time is > 0 after converting ns to =
ms*/
> > +#define TEST_SLEEP_US 10000
> > +#define TEST_SLEEP_MS (TEST_SLEEP_US / 1000)
> > +#define WAKEUP_SOURCE_NAME_LEN 32
> > +
> > +static const char test_ws_name[] =3D "bpf_selftest_ws";
> > +static bool test_ws_created;
> > +
> > +/*
> > + * Creates a new wakeup source by writing to /sys/power/wake_lock.
> > + * This lock persists until explicitly unlocked.
> > + */
> > +static int lock_ws(const char *name)
> > +{
> > +       int fd;
> > +       ssize_t bytes;
> > +
> > +       fd =3D open("/sys/power/wake_lock", O_WRONLY);
> > +       if (!ASSERT_OK_FD(fd, "open /sys/power/wake_lock"))
> > +               return -1;
> > +
> > +       bytes =3D write(fd, name, strlen(name));
> > +       close(fd);
> > +       if (!ASSERT_EQ(bytes, strlen(name), "write to wake_lock"))
> > +               return -1;
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Destroys the ws by writing the same name to /sys/power/wake_unlock.
> > + */
> > +static void unlock_ws(const char *name)
> > +{
> > +       int fd;
> > +
> > +       fd =3D open("/sys/power/wake_unlock", O_WRONLY);
> > +       if (!ASSERT_OK_FD(fd, "open /sys/power/wake_unlock"))
> > +               goto cleanup;
> > +
> > +       write(fd, name, strlen(name));
> > +
> > +cleanup:
> > +       if (fd)
> > +               close(fd);
> > +}
> > +
> > +/*
> > + * Setups for testing ws iterators. Will run once prior to suite of te=
sts.
> > + */
> > +static int setup_test_ws(void)
> > +{
> > +       if (lock_ws(test_ws_name))
> > +               return -1;
> > +       test_ws_created =3D true;
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Tears down and cleanups testing ws iterators. WIll run once after t=
he suite
> > + * of tests.
> > + */
> > +static void teardown_test_ws(void)
> > +{
> > +       if (!test_ws_created)
> > +               return;
> > +       unlock_ws(test_ws_name);
> > +       test_ws_created =3D false;
> > +}
> > +
> > +struct WakeupSourceInfo {
> > +       char name[WAKEUP_SOURCE_NAME_LEN];
> > +       unsigned long active_count;
> > +       long active_time_ms;
> > +       unsigned long event_count;
> > +       unsigned long expire_count;
> > +       long last_change_ms;
> > +       long max_time_ms;
> > +       long prevent_sleep_time_ms;
> > +       long total_time_ms;
> > +       unsigned long wakeup_count;
> > +};
> > +
> > +/*
> > + * Reads and parses one wakeup_source record from the iterator file.
> > + * A record is a single space-delimited line.
> > + * Returns true on success, false on EOF. Asserts internally on errors=
.
> > + */
> > +static bool read_ws_info(FILE *iter_file, struct WakeupSourceInfo *ws_=
info,
> > +                        char **line)
> > +{
> > +       size_t linesize;
> > +       int items;
> > +
> > +       if (getline(line, &linesize, iter_file) =3D=3D -1)
> > +               return false;
> > +
> > +       (*line)[strcspn(*line, "\n")] =3D 0;
> > +
> > +       items =3D sscanf(*line, "%s %lu %ld %lu %lu %ld %ld %ld %ld %lu=
",
> > +                      ws_info->name, &ws_info->active_count,
> > +                      &ws_info->active_time_ms, &ws_info->event_count,
> > +                      &ws_info->expire_count, &ws_info->last_change_ms=
,
> > +                      &ws_info->max_time_ms, &ws_info->prevent_sleep_t=
ime_ms,
> > +                      &ws_info->total_time_ms, &ws_info->wakeup_count)=
;
> > +
> > +       if (!ASSERT_EQ(items, 10, "read wakeup source info"))
> > +               return false;
> > +
> > +       if (!ASSERT_LT(strlen(ws_info->name), WAKEUP_SOURCE_NAME_LEN,
> > +                      "name length"))
> > +               return false;
> > +
> > +       return true;
> > +}
> > +
> > +static int get_ws_iter_stream(struct wakeup_source_iter *skel, int *it=
er_fd,
> > +                             FILE **iter_file)
> > +{
> > +       *iter_fd =3D bpf_iter_create(
> > +                       bpf_link__fd(skel->links.wakeup_source_collecto=
r));
> > +       if (!ASSERT_OK_FD(*iter_fd, "iter_create"))
> > +               return -1;
> > +
> > +       *iter_file =3D fdopen(*iter_fd, "r");
> > +       if (!ASSERT_OK_PTR(*iter_file, "fdopen"))
> > +               return -1;
> > +
> > +       return 0;
> > +}
> > +
> > +static void subtest_ws_iter_check_active_count(struct wakeup_source_it=
er *skel)
> > +{
> > +       static const char subtest_ws_name[] =3D "bpf_selftest_ws_active=
_count";
> > +       const int lock_unlock_cycles =3D 5;
> > +       struct WakeupSourceInfo ws_info;
> > +       char *line =3D NULL;
> > +       bool found_ws =3D false;
> > +       FILE *iter_file =3D NULL;
> > +       int iter_fd =3D -1;
> > +       int i;
> > +
> > +       for (i =3D 0; i < lock_unlock_cycles; i++) {
> > +               if (!ASSERT_OK(lock_ws(subtest_ws_name), "lock_ws"))
> > +                       goto cleanup;
> > +               unlock_ws(subtest_ws_name);
> > +       }
> > +
> > +       if (!get_ws_iter_stream(skel, &iter_fd, &iter_file))
> > +               goto cleanup;
> > +
> > +       while (read_ws_info(iter_file, &ws_info, &line)) {
> > +               if (strcmp(ws_info.name, subtest_ws_name) =3D=3D 0) {
> > +                       found_ws =3D true;
> > +                       ASSERT_EQ(ws_info.active_count, lock_unlock_cyc=
les,
> > +                                 "active_count check");
> > +                       ASSERT_EQ(ws_info.wakeup_count, lock_unlock_cyc=
les,
> > +                                 "wakeup_count check");
> > +                       break;
> > +               }
> > +       }
> > +
> > +       ASSERT_TRUE(found_ws, "found active_count test ws");
> > +
> > +       free(line);
> > +cleanup:
> > +       if (iter_file)
> > +               fclose(iter_file);
> > +       else if (iter_fd >=3D 0)
> > +               close(iter_fd);
> > +}
> > +
> > +static void subtest_ws_iter_check_sleep_times(struct wakeup_source_ite=
r *skel)
> > +{
> > +       bool found_test_ws =3D false;
> > +       struct WakeupSourceInfo ws_info;
> > +       char *line =3D NULL;
> > +       FILE *iter_file;
> > +       int iter_fd;
> > +
> > +       if (!get_ws_iter_stream(skel, &iter_fd, &iter_file))
> > +               goto cleanup;
> > +
> > +       while (read_ws_info(iter_file, &ws_info, &line)) {
> > +               if (strcmp(ws_info.name, test_ws_name) =3D=3D 0) {
> > +                       found_test_ws =3D true;
> > +                       ASSERT_GT(ws_info.last_change_ms, 0,
> > +                                 "Expected non-zero last change");
> > +                       ASSERT_GE(ws_info.active_time_ms, TEST_SLEEP_MS=
,
> > +                                 "Expected active time >=3D TEST_SLEEP=
_MS");
> > +                       ASSERT_GE(ws_info.max_time_ms, TEST_SLEEP_MS,
> > +                                 "Expected max time >=3D TEST_SLEEP_MS=
");
> > +                       ASSERT_GE(ws_info.total_time_ms, TEST_SLEEP_MS,
> > +                                 "Expected total time >=3D TEST_SLEEP_=
MS");
> > +                       break;
> > +               }
> > +       }
> > +
> > +       ASSERT_TRUE(found_test_ws, "found_test_ws");
> > +
> > +       free(line);
> > +cleanup:
> > +       if (iter_file)
> > +               fclose(iter_file);
> > +       else if (iter_fd >=3D 0)
> > +               close(iter_fd);
> > +}
> > +
> > +static void subtest_ws_iter_check_no_infinite_reads(
> > +               struct wakeup_source_iter *skel)
> > +{
> > +       int iter_fd;
> > +       char buf[256];
> > +
> > +       iter_fd =3D bpf_iter_create(bpf_link__fd(skel->links.wakeup_sou=
rce_collector));
> > +       if (!ASSERT_OK_FD(iter_fd, "iter_create"))
> > +               return;
> > +
> > +       while (read(iter_fd, buf, sizeof(buf)) > 0)
> > +               ;
> > +
> > +       /* Final read should return 0 */
> > +       ASSERT_EQ(read(iter_fd, buf, sizeof(buf)), 0, "read");
> > +
> > +       close(iter_fd);
> > +}
> > +
> > +void test_wakeup_source_iter(void)
> > +{
> > +       struct wakeup_source_iter *skel =3D NULL;
> > +
> > +       if (geteuid() !=3D 0) {
> > +               fprintf(stderr,
> > +                       "Skipping wakeup_source_iter test, requires roo=
t\n");
> > +               test__skip();
> > +               return;
> > +       }
> > +
> > +       skel =3D wakeup_source_iter__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "wakeup_source_iter__open_and_load"))
> > +               return;
> > +
> > +       if (!ASSERT_OK(setup_test_ws(), "setup_test_ws"))
> > +               goto destroy;
> > +
> > +       if (!ASSERT_OK(wakeup_source_iter__attach(skel), "skel_attach")=
)
> > +               goto destroy;
> > +
> > +       /*
> > +        * Sleep on O(ms) to ensure that time stats' resolution isn't l=
ost when
> > +        * converting from ns to ms
> > +        */
> > +       usleep(TEST_SLEEP_US);
> > +
> > +       if (test__start_subtest("active_count"))
> > +               subtest_ws_iter_check_active_count(skel);
> > +       if (test__start_subtest("sleep_times"))
> > +               subtest_ws_iter_check_sleep_times(skel);
> > +       if (test__start_subtest("no_infinite_reads"))
> > +               subtest_ws_iter_check_no_infinite_reads(skel);
> > +
> > +destroy:
> > +       teardown_test_ws();
> > +       wakeup_source_iter__destroy(skel);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_iter.c b/t=
ools/testing/selftests/bpf/progs/wakeup_source_iter.c
> > new file mode 100644
> > index 000000000000..9a377fd28f4e
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/wakeup_source_iter.c
> > @@ -0,0 +1,70 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2026 Google LLC */
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_core_read.h>
> > +#include <bpf/bpf_helpers.h>
> > +
> > +#define NSEC_PER_MS 1000000UL
> > +#define WAKEUP_SOURCE_NAME_LEN 32
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +SEC("iter/wakeup_source")
> > +int wakeup_source_collector(struct bpf_iter__wakeup_source *ctx)
> > +{
> > +       const struct wakeup_source *ws =3D ctx->wakeup_source;
> > +       struct seq_file *seq =3D ctx->meta->seq;
> > +       char name[WAKEUP_SOURCE_NAME_LEN] =3D {'\0'};
> > +       const char *pname;
> > +       bool active, autosleep_enable;
> > +       u64 active_count, event_count, expire_count, wakeup_count;
> > +       s64 active_time, curr_time, last_change_time, max_time,
> > +           prevent_sleep_time, start_prevent_time, total_time;
> > +
> > +       if (!ws)
> > +               return 0;
> > +
> > +       active =3D BPF_CORE_READ_BITFIELD_PROBED(ws, active);
> > +       autosleep_enable =3D BPF_CORE_READ_BITFIELD_PROBED(ws, autoslee=
p_enabled);
> > +       if (bpf_core_read(&pname, sizeof(pname), &ws->name) ||
> > +           bpf_probe_read_kernel_str(name, sizeof(name), pname) < 0 ||
> > +           bpf_core_read(&active_count, sizeof(active_count), &ws->act=
ive_count) ||
> > +           bpf_core_read(&event_count, sizeof(event_count), &ws->event=
_count) ||
> > +           bpf_core_read(&expire_count, sizeof(expire_count), &ws->exp=
ire_count) ||
> > +           bpf_core_read(&last_change_time, sizeof(last_change_time), =
&ws->last_time) ||
> > +           bpf_core_read(&max_time, sizeof(max_time), &ws->max_time) |=
|
> > +           bpf_core_read(
> > +               &prevent_sleep_time, sizeof(prevent_sleep_time), &ws->p=
revent_sleep_time) ||
> > +           bpf_core_read(
> > +               &start_prevent_time, sizeof(start_prevent_time), &ws->s=
tart_prevent_time) ||
> > +           bpf_core_read(&total_time, sizeof(total_time), &ws->total_t=
ime) ||
> > +           bpf_core_read(&wakeup_count, sizeof(wakeup_count), &ws->wak=
eup_count))
> > +               return 0;
>
> you really don't need to do this for types returned from iterators,
> try just accessing ws->start_prevent_time (and any other field)
> directly
>

Thanks for reviewing Andrii. That is much cleaner. I'll address this
and the bot's comments in v3.

> > +
> > +
> > +       curr_time =3D bpf_ktime_get_ns();
> > +       active_time =3D 0;
> > +       if (active) {
> > +               active_time =3D curr_time - last_change_time;
> > +               total_time +=3D active_time;
> > +               if (active_time > max_time)
> > +                       max_time =3D active_time;
> > +               if (autosleep_enable)
> > +                       prevent_sleep_time +=3D curr_time - start_preve=
nt_time;
> > +
> > +       }
> > +
> > +       BPF_SEQ_PRINTF(seq,
> > +                      "%s %lu %ld %lu %lu %ld %ld %ld %ld %lu\n",
> > +                      name,
> > +                      active_count,
> > +                      active_time / NSEC_PER_MS,
> > +                      event_count,
> > +                      expire_count,
> > +                      last_change_time / NSEC_PER_MS,
> > +                      max_time / NSEC_PER_MS,
> > +                      prevent_sleep_time / NSEC_PER_MS,
> > +                      total_time / NSEC_PER_MS,
> > +                      wakeup_count);
> > +       return 0;
> > +}
> > --
> > 2.52.0.457.g6b5491de43-goog
> >
