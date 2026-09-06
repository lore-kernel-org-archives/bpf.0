Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843F23BE168
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788727947; cv=pass; b=rrmUdgePXktHOtIIvLTVCpFEcPje7LE25Qet3kwOqVV82FF5VMEF5Ooy1EimMxsY+jRh7nx4j8F+GLSSlLjZPd+0RmaeBm5M/StvfVWlH6/ZFsrEIas0eC8IIsokaO0NU0xu18rQGDXMnyJEBPDT2b+76Z8qydeF7lmm0HBrepE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788727947; c=relaxed/simple;
	bh=SXkkL1leCpadgAIXFmuk9vFBMaL9VMcynsn8nNsQidE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHhuuUIWfvsj+2LSU2ERQFORNOxyDsmtj+G2ZI1x/Vc3IJrXrbTeDWQyk8TyML20ciylHxNwhaMbl1a0RxINe8a3G9kcyypYX2KmAcAy8sREOikp8RLiue+mJTFdHsorkPKKxQRB/l4dFVx5pi2p4wNfjOLNBVril+x1QysIXoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+7vSHu1; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+7vSHu1"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a33307ecd9so31571091fa.2
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 13:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788727943; cv=none;
        d=google.com; s=arc-20260327;
        b=Ke8q7d7EXS1kRR3+oR9VXVEBgqeeN+PMD3dE5ECGWOCEB+eGutdy7HiKD94kmBBUzg
         u21C/v9KR7p3VZl70IGA5ozr2YGIpcm4Vqg+1YmzWHBBEFgT72uevmcx5tfvAyOeM1sd
         RgdQmO7CNEB2AEY5Uf3ghiFguEHch2iJno51kmuL0Hr135O/i5gRpizb8wtVJfbZjOfr
         sJcQtIY+fLKiZDE51w8iu8sTTXRX4mnJJyOLEPRDW3mORefhLPaeSgYh0EHzIU/x+fTp
         i8VEJ60MIZ7h4Xy3UcClXlQFWc3SwbV/p210uInljKP4KQRm/jjcBEtt/IbkT0RS8OR6
         6lIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tLEUcwxYVbj+5BS/ostM1lAmEHO6bgKhQj06vkhAg0Y=;
        fh=fAUcOLMJrL6/gSlJAi6JxZuXRW8JDI9oXae6bn18h+k=;
        b=haNHpBdetFB+lTBDeaJZ74w5YAPWcWy8Qz0luV81L07tORePW/kfFNAA092tPP8Ipk
         Cmsn972KVBp2RfTfyGF3xF+YqQBEC2s7s+b/FeGLCRZP52iz1ZBc4GZ+07u4SSuWthx1
         L3vOHJ2Q9T/jqOduzxaPJJ/h9FHKhGFsf1QTkDm6UdxkBUu7gzXWeSL3PUppbHyXjZv2
         ZIegsKwoRf3Ek2cNhBDB8B8YH9iAqmpS9YD80pwkJXDUd3c+GooTr3GiHq1s1NmM75Ee
         c9ngopYBIzvfwOMFVDugUInxPuD58F+N6GAOD/uvvKw/dWpOUtK9T99JHDSRoEu7baIl
         TKHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788727943; x=1789332743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tLEUcwxYVbj+5BS/ostM1lAmEHO6bgKhQj06vkhAg0Y=;
        b=B+7vSHu1bIGhx9RJykdun8jtLDsxEq/uWn3NppP9wxArDzS3z2FeswFvKsinL4NQIq
         y0At7RAkG3GK9quhw7v+qmasQ7UhxFFHwAdNGOpzH9o2zgLsgcqXSPZlEofMZ1ZRqwFh
         vKK0vAwjR7A8/+72jim7Isun6T3SFXDUhWwD8swv9nS+G7QQX59KCXfFAj9WvCCF1Vfx
         Fj7ifJRIIa8Eo9mSaB5QreJOuksbNZVTA5hK2ja7gsMJdkUAExIeR+vrSjGj0mXW4KF3
         G0tGdkER19ZJ5eY+MEJugim9UjfJUBq3LRwn3cfNVLalvvkYF3kUS3m1R+AlumSAbN2O
         kJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788727943; x=1789332743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tLEUcwxYVbj+5BS/ostM1lAmEHO6bgKhQj06vkhAg0Y=;
        b=PE0qY8gfRnnJlH7eRUMzvUXRIDzJD23r6IlksnsMPnZAA8vsCDbgGhjhgpfIafRXlo
         jUwsH6h+EznNiFga1NAFGaBGVuvi2uirz/WXtKA57Yyc3pU9Ya+DxEl94PJfqY0S5l7w
         htXTIk0NAtTZYlzLXK8B1wOn01CicTy2pm6lOsDDTnlgpzugfA9ozCStRHk3xuIWkJYp
         NUandhqzdfNEkFEEEK6/jynmgm1wfXC9A0VEHpEcz/rZ7jknEtFX0RW3zByzTTMVL91U
         uX+ZA6Vm9zeJbh34Bw5EhuJEhpbJR2RoHMZg3fQz8/rsk1NyvKyRYgtXjNGAeqJLF3IK
         5F0g==
X-Gm-Message-State: AFuF++lxdaPCTiKBFqZCcHQM87OG8nloT53KH1ii3QKPn21cORwvqd85
	HZ1uoT0NOawXz27CeVlNjaEZGv2ztcHV8bNun1b1aht5QMJYQLcCSxiviSz3cInq8cgNmvc0VYf
	sKbcmcmCq60An+8O16Xji6+A3H+4VvIE=
X-Gm-Gg: AYBFou0iVD9FUS2ys033Ex5P7jB4LP1G4LrdYtdEE3SezR/G2ewnQeWhl88LZItrN40
	wp93eErE0N54CsMMYIc94EAinQIEBBRvRUDJkn7vopvqMrNlpu37PMyvXL2/CoZiTal7bmEYodF
	sJXRP7uQSf3uroGnCeLSg89UeDRL6BwzSzQsHVFXeNuw5mKCzXJ8E4d1ZKZwgSS1eQ7Cohhs9lJ
	0dDm/9kUs3oGmvVjaUqWgfwVH1CIizmicWDdLBk7m0q0HgEHH7dKlGPGjwOF4z/zpE6veIKkQDp
	3Qp9/oTW3O8xjgZaEcSdsDPxYhX0bnlM+7VB2qJnAYTSi5yWh0/ayzl7KP2R7LLmWcSGodKD6md
	L2oDAz46VapW6FKw=
X-Received: by 2002:a05:651c:a38f:10b0:3a3:7681:6d5d with SMTP id
 38308e7fff4ca-3a37681748cmr11742711fa.21.1788727942625; Sun, 06 Sep 2026
 13:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
 <20260906-perf-gtk2-v7-1-1ece839fbca0@gmail.com> <20260906202542.E548D1F00A3A@smtp.kernel.org>
In-Reply-To: <20260906202542.E548D1F00A3A@smtp.kernel.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 6 Sep 2026 16:52:10 -0400
X-Gm-Features: AcwNN1UluC9sCF1AfaoB_QDn5rUqNCsIttJ4OM-0bXZJ5LOVybQjVpfERdAc7tU
Message-ID: <CAEdQ38EqhLXyZiR5P-gXtQrrEjceamN8FEVXcYvrbVvqJmduZA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] tools: port perf ui from GTK 2 to GTK 4
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 4:25=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Connecting to the removed 'destroy' signal in GTK4 causes main=
 loop hangs and use-after-free/double-free bugs.
> --
>
> commit fc78f437c6f22aa072d608cee2f291c6178f6853
> Author: Matt Turner <mattst88@gmail.com>
>
>     tools: port perf ui from GTK 2 to GTK 4
>
>     Port straight to GTK 4 rather than GTK 3, since GTK 4 is where new
>     development happens and GTK 3 is old itself now.
>
> > diff --git a/tools/perf/ui/gtk/progress.c b/tools/perf/ui/gtk/progress.=
c
> > index eea6fcde518a8..770f9251b54b7 100644
> > --- a/tools/perf/ui/gtk/progress.c
> > +++ b/tools/perf/ui/gtk/progress.c
> > @@ -1,49 +1,65 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <inttypes.h>
> > +#include <stdio.h>
>
> [ ... ]
>
> > +static void gtk_ui_progress__destroyed(GtkWidget *widget __maybe_unuse=
d,
> > +                                     gpointer data __maybe_unused)
> > +{
> > +     dialog =3D NULL;
> > +     progress =3D NULL;
> > +}
> > +
> >  static void gtk_ui_progress__update(struct ui_progress *p)
> >  {
> >       double fraction =3D p->total ? 1.0 * p->curr / p->total : 0.0;
> >       char buf[1024];
> >
> >       if (dialog =3D=3D NULL) {
> > -             GtkWidget *vbox =3D gtk_vbox_new(TRUE, 5);
> > +             GtkWidget *vbox =3D gtk_box_new(GTK_ORIENTATION_VERTICAL,=
 5);
> >               GtkWidget *label =3D gtk_label_new(p->title);
> >
> > -             dialog =3D gtk_window_new(GTK_WINDOW_TOPLEVEL);
> > +             dialog =3D gtk_window_new();
> >               progress =3D gtk_progress_bar_new();
> >
> > -             gtk_box_pack_start(GTK_BOX(vbox), label, TRUE, FALSE, 3);
> > -             gtk_box_pack_start(GTK_BOX(vbox), progress, TRUE, TRUE, 3=
);
> > +             gtk_widget_set_vexpand(label, TRUE);
> > +             gtk_box_append(GTK_BOX(vbox), label);
> > +             gtk_widget_set_vexpand(progress, TRUE);
> > +             gtk_box_append(GTK_BOX(vbox), progress);
> > +
> > +             gtk_window_set_child(GTK_WINDOW(dialog), vbox);
> >
> > -             gtk_container_add(GTK_CONTAINER(dialog), vbox);
> > +             g_signal_connect(dialog, "destroy",
> > +                              G_CALLBACK(gtk_ui_progress__destroyed), =
NULL);
>
> [Severity: Medium]
> In gtk_ui_progress__update(), will this signal connection fail at runtime=
?
> The destroy signal was removed from GtkWidget in GTK 4. If it fails silen=
tly,
> gtk_ui_progress__destroyed() would not be called to nullify the pointer w=
hen
> the user manually closes the progress window. This could result in a
> use-after-free or double-free crash when gtk_ui_progress__finish() is
> subsequently called on the already-freed pointer.

Incorrect. GTK4 did not remove the destroy signal from GtkWidget, only
the gtk_widget_destroy() function was removed. The signal is still
registered in gtk/gtkwidget.c (g_signal_new(I_("destroy"), ...)) and
emitted from gtk_widget_dispose(). Verified against upstream GTK
source, and confirmed live via GObject.signal_list_names(Gtk.Widget)
on GTK 4.20.4: destroy is present. g_signal_connect(dialog, "destroy",
...) connects fine and fires. No change needed.

> [ ... ]
>
> > diff --git a/tools/perf/ui/gtk/util.c b/tools/perf/ui/gtk/util.c
> > index c47f5c387838c..5823ff0d7c2a7 100644
> > --- a/tools/perf/ui/gtk/util.c
> > +++ b/tools/perf/ui/gtk/util.c
> > @@ -28,86 +30,103 @@ int perf_gtk__deactivate_context(struct perf_gtk_c=
ontext **ctx)
>
> [ ... ]
>
> > +     /*
> > +      * "response" only fires when a button is clicked; DESTROY_WITH_P=
ARENT
> > +      * destroys the dialog directly without it. Quit from "destroy"
> > +      * instead, which fires either way, so the nested loop below can'=
t
> > +      * outlive the dialog and hang.
> > +      */
> > +     loop =3D g_main_loop_new(NULL, FALSE);
> > +     perf_gtk__error_loops =3D g_slist_prepend(perf_gtk__error_loops, =
loop);
> > +     g_signal_connect(dialog, "response",
> > +                      G_CALLBACK(perf_gtk__dialog_response), NULL);
> > +     g_signal_connect_swapped(dialog, "destroy",
> > +                              G_CALLBACK(g_main_loop_quit), loop);
>
> [Severity: Medium]
> In perf_gtk__error(), since the destroy signal no longer exists in GTK 4,
> could this leave the nested main loop running indefinitely and hanging th=
e
> application? Because the destroy signal is not emitted when the dialog is
> closed (even via the confirmation button), g_main_loop_quit() will never =
be
> called.

Also incorrect, same misunderstanding of the destroy signal. When the
user closes the dialog via the window controls, gtk_window_close()
calls gtk_window_emit_close_request(). The default close_request
handler returns FALSE (no hide_on_close set), so control falls through
to gtk_window_destroy(), which drops GTK's internal toplevel ref and
finalizes the widget, emitting destroy. That is exactly the signal
perf_gtk__error() connects to stop the nested loop. Confirmed by
reading gtk_window_close() and gtk_window_destroy() in gtkwindow.c,
and gtk_widget_dispose() in gtkwidget.c, in current GTK upstream. No
hang. No change needed.
