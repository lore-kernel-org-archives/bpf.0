Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66618C432BE
	for <bpf@archiver.kernel.org>; Sun,  8 Aug 2021 21:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D0B60E97
	for <bpf@archiver.kernel.org>; Sun,  8 Aug 2021 21:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhHHV7u (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 8 Aug 2021 17:59:50 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:57223 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhHHV7t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 Aug 2021 17:59:49 -0400
Date:   Sun, 08 Aug 2021 21:59:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thesw4rm.com;
        s=protonmail2; t=1628459965;
        bh=n8plPI4j6Kr77c97B5VEWI+pK299/Z77wwYXp+Kb+xs=;
        h=Date:To:From:Reply-To:Subject:From;
        b=QqK8o29N9suAH7l+hOpV8legX+Ra9SgDcRfXqWn5a8mbp9LzX2BR0MK3M4N9WZJNi
         C1j/CHU0JKPgauJ0sAQS/3IkkMROrbkshI3xzu+qJlqf13fcKGeJMs5o7IezzdaKSd
         vSRFIgspp76gfHhwV7olUNiokczzJ7pdEMfErs22HEjYOJCWlW6vZcQiVuX7xIayqK
         XirWITUrDBd/r9A22Y2tKspL/qq0m/K9CK+PItwdMRbB74XyN12nMXE/yxg8m1I45E
         u/T5kKISUWe+G7w3OiwATT01yH9DYKkJMMquogxi67yddxt0dzjHVQoSHrFRzGGV9J
         afDOAzQbnt0Zw==
To:     bpf@vger.kernel.org
From:   Yadunandan Pillai <ytpillai@thesw4rm.com>
Reply-To: Yadunandan Pillai <ytpillai@thesw4rm.com>
Subject: Update percpu array from userspace?
Message-ID: <20210808215914.weaqxmsqgvmtbvep@bigdesk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

Conceptually, what would be the process behind updating a percpu map
from userspace? Looking up elements is fairly simple to digest. (For
example).

-------

int map_fd =3D bpf_create_map_name(
        BPF_MAP_TYPE_PERCPU_ARRAY,
        "map_name",
        sizeof(__u32),
        sizeof(__u32),
        10,
        0
);

int key =3D 4;
int values[nr_cpus];

bpf_map_lookup_elem(map_fd, &key, values);

-------

This gets the fifth element for each percpu array.

But how do you update the values in each percpu array from the
"values" array? If you can directly run bpf_map_update_elem() on the
file descriptor, does that mean that the updated value is automatically
replicated across all percpu arrays? What if you wanted to update a
specific percpu array?

